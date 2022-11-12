class BudgetsController < ApplicationController

  def index
    @month = Month.find_by(user_id: current_user.id, id: params[:month_id])
    @second_latest_month = Month.where(user_id: current_user.id).includes(:user).order(month: :desc).second
    @last_budget = Budget.find_by(month_id: @second_latest_month.id)
    @last_spending_rent = Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :rent).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :rent).includes(:month).sum(:income)
    @last_spending_food = Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :food).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :food).includes(:month).sum(:income)
    @last_spending_life = Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :life).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :life).includes(:month).sum(:income)
    @last_spending_enjoy = Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :enjoy).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :enjoy).includes(:month).sum(:income)
    @last_spending_other = Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :other).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: @second_latest_month.id, classification: :other).includes(:month).sum(:income)
    authenticate_budget
    @setting = Budget.new
    if @budget.present?
      @spending_rent = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :rent).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :rent).includes(:month).sum(:income)
      @spending_food = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :food).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :food).includes(:month).sum(:income)
      @spending_life = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :life).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :life).includes(:month).sum(:income)
      @spending_enjoy = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :enjoy).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :enjoy).includes(:month).sum(:income)
      @spending_other = Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :other).includes(:month).sum(:spending) - Detail.where(user_id: current_user.id, month_id: params[:month_id], classification: :other).includes(:month).sum(:income)
      @spending_total = @spending_rent + @spending_food + @spending_life + @spending_enjoy + @spending_other
      @budget_total = @budget.rent + @budget.food + @budget.life + @budget.enjoy + @budget.other
      @rent_percent = @budget.rent == 0 ? 0 : @spending_rent * 100 / @budget.rent
      @life_percent = @budget.life == 0 ? 0 : @spending_life * 100 / @budget.life
      @food_percent = @budget.food == 0 ? 0 : @spending_food * 100 / @budget.food
      @enjoy_percent = @budget.enjoy == 0 ? 0 : @spending_enjoy * 100 / @budget.enjoy
      @other_percent = @budget.other == 0 ? 0 : @spending_other * 100 / @budget.other
      @total_percent = @budget_total == 0 ? 0 : @spending_total * 100 / @budget_total
      @bar_cahrt = [[:家賃, @rent_percent],[:生活費, @life_percent],[:食費, @food_percent],[:交際費, @enjoy_percent],[:ペット費, @other_percent],[:合計, @total_percent]]
      rent = @spending_rent == 0 ? "" : "家賃"
      life = @spending_life == 0 ? "" : "生活費"
      food = @spending_food == 0 ? "" : "食費"
      enjoy = @spending_enjoy == 0 ? "" : "交際費"
      other = @spending_other == 0 ? "" : "ペット費"
      @pie_chart = [[rent, @spending_rent],[life, @spending_life],[food, @spending_food],[enjoy, @spending_enjoy],[other, @spending_other]]
    end
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

  def authenticate_budget
    @budget = Budget.find_by(user_id: current_user.id, month_id: params[:month_id])
  end
end
