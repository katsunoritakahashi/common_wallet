class BudgetsController < ApplicationController
  before_action :budget_other_entry, only: %i[index]

  def index
    each_month
    authenticate_budget
    @setting = Budget.new
    if @budget.present?
      @spending_rent = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :rent).includes(:month).sum(:spending)
      @spending_food = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :food).includes(:month).sum(:spending)
      @spending_life = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :life).includes(:month).sum(:spending)
      @spending_enjoy = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :enjoy).includes(:month).sum(:spending)
      @spending_other = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :other).includes(:month).sum(:spending)
      @spending_total = @spending_rent + @spending_food + @spending_life + @spending_enjoy + @spending_other
      #binding.irb
      @budget_total = @budget.rent + @budget.food + @budget.life + @budget.enjoy + @budget.other
      pie_chart
      @bar_cahrt = [[:家賃, @spending_rent * 100 / @budget.rent],[:生活費, @spending_life * 100 / @budget.food],[:食費, @spending_food * 100 / @budget.life],[:交際費, @spending_enjoy * 100 / @budget.enjoy]]
    end
  end

  def show
  end

  def create
    @add = Budget.new(budget_params)
    if !authenticate_budget
      @add.month_id = params[:month_id]
      @add.user_id = current_user.id
      if @add.save
        redirect_back_or_to month_budgets_path, success: '予算を設定しました'
      else
        redirect_back_or_to month_budgets_path, danger: '予算を設定できませんでした'
      end
    else 
      redirect_back_or_to month_budgets_path, danger: '予算は既に設定されています'
    end 
  end

  def destroy
    @budget = Budget.find_by(user_id: current_user.id, id: params[:id])
    @budget.destroy!
    redirect_back_or_to month_budgets_path(@budget.month_id)
  end

  private

  def budget_params
    params.permit(:rent, :food, :life, :enjoy, :other)
  end

  def each_month
    @month = Month.find_by(user_id: current_user.id, id: params[:month_id])
  end

  def authenticate_budget
    @budget = Budget.find_by(user_id: current_user.id, month_id: params[:month_id])
  end

  def budget_other_entry
    @budget = Budget.find_by(user_id: current_user.id, month_id: params[:month_id])
    @budget.other = 0 if @budget.other.blank?
    @budget.save
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
