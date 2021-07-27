class ProfilesController < ApplicationController
  skip_before_action :require_login, only: %i[new create edit update]
  skip_before_action :authenticated_this_month, only: %i[new destroy create]

  def show
    @user = User.find(current_user.id)
    @months = Month.where(user_id: current_user.id)
    if @months.present?
      @this_month = Date.today.all_month
      @column_chart = Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(12).pluck(:month, :balance_last)
      @colum_chart_max =Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(12).pluck(:balance_last).max
      @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
      @detail = Detail.where(user_id: current_user.id, month_id: @month.id) if @month.present?
      @budget = Budget.find_by(user_id: current_user.id, month_id: @month.id) if @month.present?
      if @detail.present?
        @not_yet_count = Detail.where(user_id: current_user.id, month_id: @month.id, status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').count(:id)
        @spending_rent = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :rent).includes(:month).sum(:spending)
        @spending_food = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :food).includes(:month).sum(:spending)
        @spending_life = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :life).includes(:month).sum(:spending)
        @spending_enjoy = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :enjoy).includes(:month).sum(:spending)
        @spending_other = Detail.where(user_id: current_user.id, month_id: @month.id, classification: :other).includes(:month).sum(:spending)
        @spending_total = @spending_rent + @spending_food + @spending_life + @spending_enjoy + @spending_other
        @budget_total = @budget.rent + @budget.food + @budget.life + @budget.enjoy + @budget.other
        rent = @spending_rent == 0 ? "" : "家賃"
        life = @spending_life == 0 ? "" : "生活費"
        food = @spending_food == 0 ? "" : "食費"
        enjoy = @spending_enjoy == 0 ? "" : "交際費"
        other = @spending_other == 0 ? "" : "その他"
        @pie_chart = [[rent, @spending_rent],[life, @spending_life],[food, @spending_food],[enjoy, @spending_enjoy],[other, @spending_other]]
        @replayers = Detail.where(user_id: current_user.id, month_id: @month.id, status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').group(:replayer)
        @details = Detail.where(user_id: current_user.id, month_id: @month.id, status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').includes(:month).order(date: :asc)
        @income_total_not_common = Detail.where(user_id: current_user.id, month_id: @month.id, status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').includes(:month).sum(:income)
        @spending_total_not_common = Detail.where(user_id: current_user.id, month_id: @month.id, status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').includes(:month).sum(:spending)
        @balance_of_payments_not_common = @income_total_not_common - @spending_total_not_common
        @done_income = Detail.where(user_id: current_user.id, month_id: @month.id, status: :done).sum(:income)
        @done_spending = Detail.where(user_id: current_user.id, month_id: @month.id, status: :done).sum(:spending)
      end
    end
  end

  def edit
    @user_edit = User.find(current_user.id)
  end

  def update
    @user_edit = User.find(current_user.id)
    if @user_edit.update(user_params)
      redirect_back_or_to profile_path, success: 'ユーザー情報を変更しました'
    else
      redirect_back_or_to edit_profile_path, danger: 'ユーザー情報を変更できませんでした'
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
end