class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create edit update]
  skip_before_action :authenticated_this_month, only: %i[new destroy create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #binding.irb
    if @user.save
      redirect_back_or_to months_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録ができませんでした'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @months = Month.where(user_id: current_user.id)
    if @months.present?
      @this_month = Date.today.all_month
      @column_chart = Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(7).pluck(:month, :balance_last)
      @colum_chart_max =Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(7).pluck(:balance_last).max
      @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
      @detail = Detail.where(user_id: current_user.id, month_id: @month.id) if @month.present?
      @budget = Budget.where(user_id: current_user.id, month_id: @month.id) if @month.present?
      if @detail.present?
        @not_yet_count = Detail.where(user_id: current_user.id, month_id: @month.id, status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').count(:id)
        @spending_rent = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :rent).includes(:month).sum(:spending)
        @spending_food = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :food).includes(:month).sum(:spending)
        @spending_life = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :life).includes(:month).sum(:spending)
        @spending_enjoy = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :enjoy).includes(:month).sum(:spending)
        @spending_other = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :other).includes(:month).sum(:spending)
        @spending_total = @spending_rent + @spending_food + @spending_life + @spending_enjoy + @spending_other
        pie_chart
        #binding.irb
      end
    end
    #binding.irb
  end

  def edit
    @user_edit = User.find(current_user.id)
  end

  def update
    @user_edit = User.find(current_user.id)
    if @user_edit.update(user_params)
      redirect_back_or_to user_path, success: 'ユーザー情報を変更しました'
    else
      redirect_back_or_to edit_user_path, danger: 'ユーザー情報を変更できませんでした'
    end
  end

  def destroy
    @user = current_user
    @user.destroy!
    redirect_back_or_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def pie_chart
    if @spending_rent != 0 && @spending_life != 0 && @spending_food != 0 && @spending_enjoy != 0 && @spending_other != 0
      @pie_chart = [[:家賃, @spending_rent],[:生活費, @spending_life],[:食費, @spending_food],[:交際費, @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent == 0 && @spending_life != 0 && @spending_food != 0 && @spending_enjoy != 0 && @spending_other != 0
      @pie_chart = [["", @spending_rent],[:生活費, @spending_life],[:食費, @spending_food],[:交際費, @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent != 0 && @spending_life == 0 && @spending_food != 0 && @spending_enjoy != 0 && @spending_other != 0
      @pie_chart = [[:家賃, @spending_rent],["", @spending_life],[:食費, @spending_food],[:交際費, @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent == 0 && @spending_life == 0 && @spending_food != 0 && @spending_enjoy != 0 && @spending_other != 0
      @pie_chart = [["", @spending_rent],["", @spending_life],[:食費, @spending_food],[:交際費, @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent != 0 && @spending_life != 0 && @spending_food == 0 && @spending_enjoy != 0 && @spending_other != 0
      @pie_chart = [[:家賃, @spending_rent],[:生活費, @spending_life],["", @spending_food],[:交際費, @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent == 0 && @spending_life != 0 && @spending_food == 0 && @spending_enjoy != 0 && @spending_other != 0
      @pie_chart = [["", @spending_rent],[:生活費, @spending_life],["", @spending_food],[:交際費, @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent != 0 && @spending_life == 0 && @spending_food == 0 && @spending_enjoy != 0 && @spending_other != 0
      @pie_chart = [[:家賃, @spending_rent],["", @spending_life],["", @spending_food],[:交際費, @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent == 0 && @spending_life == 0 && @spending_food == 0 && @spending_enjoy != 0 && @spending_other != 0
      @pie_chart = [["", @spending_rent],["", @spending_life],["", @spending_food],[:交際費, @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent != 0 && @spending_life != 0 && @spending_food != 0 && @spending_enjoy == 0 && @spending_other != 0
      @pie_chart = [[:家賃, @spending_rent],[:生活費, @spending_life],[:食費, @spending_food],["", @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent == 0 && @spending_life != 0 && @spending_food != 0 && @spending_enjoy == 0 && @spending_other != 0
      @pie_chart = [["", @spending_rent],[:生活費, @spending_life],[:食費, @spending_food],["", @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent != 0 && @spending_life == 0 && @spending_food != 0 && @spending_enjoy == 0 && @spending_other != 0
      @pie_chart = [[:家賃, @spending_rent],["", @spending_life],[:食費, @spending_food],["", @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent == 0 && @spending_life == 0 && @spending_food != 0 && @spending_enjoy == 0 && @spending_other != 0
      @pie_chart = [["", @spending_rent],["", @spending_life],[:食費, @spending_food],["", @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent != 0 && @spending_life != 0 && @spending_food == 0 && @spending_enjoy == 0 && @spending_other != 0
      @pie_chart = [[:家賃, @spending_rent],[:生活費, @spending_life],["", @spending_food],["", @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent == 0 && @spending_life != 0 && @spending_food == 0 && @spending_enjoy == 0 && @spending_other != 0
      @pie_chart = [["", @spending_rent],[:生活費, @spending_life],["", @spending_food],["", @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent != 0 && @spending_life == 0 && @spending_food == 0 && @spending_enjoy == 0 && @spending_other != 0
      @pie_chart = [[:家賃, @spending_rent],["", @spending_life],["", @spending_food],["", @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent == 0 && @spending_life == 0 && @spending_food == 0 && @spending_enjoy == 0 && @spending_other != 0
      @pie_chart = [["", @spending_rent],["", @spending_life],["", @spending_food],["", @spending_enjoy],[:その他, @spending_other]]
    elsif @spending_rent != 0 && @spending_life != 0 && @spending_food != 0 && @spending_enjoy != 0 && @spending_other == 0
      @pie_chart = [[:家賃, @spending_rent],[:生活費, @spending_life],[:食費, @spending_food],[:交際費, @spending_enjoy],["", @spending_other]]
    elsif @spending_rent == 0 && @spending_life != 0 && @spending_food != 0 && @spending_enjoy != 0 && @spending_other == 0
      @pie_chart = [["", @spending_rent],[:生活費, @spending_life],[:食費, @spending_food],[:交際費, @spending_enjoy],["", @spending_other]]
    elsif @spending_rent != 0 && @spending_life == 0 && @spending_food != 0 && @spending_enjoy != 0 && @spending_other == 0
      @pie_chart = [[:家賃, @spending_rent],["", @spending_life],[:食費, @spending_food],[:交際費, @spending_enjoy],["", @spending_other]]
    elsif @spending_rent == 0 && @spending_life == 0 && @spending_food != 0 && @spending_enjoy != 0 && @spending_other == 0
      @pie_chart = [["", @spending_rent],["", @spending_life],[:食費, @spending_food],[:交際費, @spending_enjoy],["", @spending_other]]
    elsif @spending_rent != 0 && @spending_life != 0 && @spending_food == 0 && @spending_enjoy != 0 && @spending_other == 0
      @pie_chart = [[:家賃, @spending_rent],[:生活費, @spending_life],["", @spending_food],[:交際費, @spending_enjoy],["", @spending_other]]
    elsif @spending_rent == 0 && @spending_life != 0 && @spending_food == 0 && @spending_enjoy != 0 && @spending_other == 0
      @pie_chart = [["", @spending_rent],[:生活費, @spending_life],["", @spending_food],[:交際費, @spending_enjoy],["", @spending_other]]
    elsif @spending_rent != 0 && @spending_life == 0 && @spending_food == 0 && @spending_enjoy != 0 && @spending_other == 0
      @pie_chart = [[:家賃, @spending_rent],["", @spending_life],["", @spending_food],[:交際費, @spending_enjoy],["", @spending_other]]
    elsif @spending_rent == 0 && @spending_life == 0 && @spending_food == 0 && @spending_enjoy != 0 && @spending_other == 0
      @pie_chart = [["", @spending_rent],["", @spending_life],["", @spending_food],[:交際費, @spending_enjoy],["", @spending_other]]
    elsif @spending_rent != 0 && @spending_life != 0 && @spending_food != 0 && @spending_enjoy == 0 && @spending_other == 0
      @pie_chart = [[:家賃, @spending_rent],[:生活費, @spending_life],[:食費, @spending_food],["", @spending_enjoy],["", @spending_other]]
    elsif @spending_rent == 0 && @spending_life != 0 && @spending_food != 0 && @spending_enjoy == 0 && @spending_other == 0
      @pie_chart = [["", @spending_rent],[:生活費, @spending_life],[:食費, @spending_food],["", @spending_enjoy],["", @spending_other]]
    elsif @spending_rent != 0 && @spending_life == 0 && @spending_food != 0 && @spending_enjoy == 0 && @spending_other == 0
      @pie_chart = [[:家賃, @spending_rent],["", @spending_life],[:食費, @spending_food],["", @spending_enjoy],["", @spending_other]]
    elsif @spending_rent == 0 && @spending_life == 0 && @spending_food != 0 && @spending_enjoy == 0 && @spending_other == 0
      @pie_chart = [["", @spending_rent],["", @spending_life],[:食費, @spending_food],["", @spending_enjoy],["", @spending_other]]
    elsif @spending_rent != 0 && @spending_life != 0 && @spending_food == 0 && @spending_enjoy == 0 && @spending_other == 0
      @pie_chart = [[:家賃, @spending_rent],[:生活費, @spending_life],["", @spending_food],["", @spending_enjoy],["", @spending_other]]
    elsif @spending_rent == 0 && @spending_life != 0 && @spending_food == 0 && @spending_enjoy == 0 && @spending_other == 0
      @pie_chart = [["", @spending_rent],[:生活費, @spending_life],["", @spending_food],["", @spending_enjoy],["", @spending_other]]
    elsif @spending_rent != 0 && @spending_life == 0 && @spending_food == 0 && @spending_enjoy == 0 && @spending_other == 0
      @pie_chart = [[:家賃, @spending_rent],["", @spending_life],["", @spending_food],["", @spending_enjoy],["", @spending_other]]
    else @spending_rent == 0 && @spending_life == 0 && @spending_food == 0 && @spending_enjoy == 0 && @spending_other == 0
      @pie_chart = [["", @spending_rent],["", @spending_life],["", @spending_food],["", @spending_enjoy],["", @spending_other]]
    end
  end
end
