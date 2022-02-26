class DepositsController < ApplicationController
  def index
    @month = Month.find_by(user_id: current_user.id, id: params[:month_id])
    authenticate_deposit
    @second_latest_month = Month.where(user_id: current_user.id).includes(:user).order(month: :desc).second
    @last_deposit = Deposit.find_by(month_id: @second_latest_month.id)
    @correct_total_man = Correct.where(user_id: current_user.id, month_id: params[:month_id], player: "旦那").sum(:correct_amount)
    @correct_total_woman = Correct.where(user_id: current_user.id, month_id: params[:month_id], player: "嫁").sum(:correct_amount)
    @corrects = Correct.where(user_id: current_user.id, month_id: params[:month_id]).order(created_at: :asc)
    if @deposit.present?
      @correct_man_salary = @deposit.man_salary - @correct_total_man
      @correct_woman_salary = @deposit.woman_salary - @correct_total_woman
      @disposable_income = (@correct_man_salary + @correct_woman_salary - @deposit.total_deposit) / 2
      @disposable_income_man = @disposable_income + @correct_total_man
      @disposable_income_woman = @disposable_income + @correct_total_woman
      @man_deposit = @deposit.man_salary - @disposable_income_man
      @woman_deposit = @deposit.woman_salary - @disposable_income_woman
    end
  end

  def create
    @add = Deposit.new(deposit_params)
    if !authenticate_deposit
      @add.month_id = params[:month_id]
      @add.user_id = current_user.id
      if @add.save
        redirect_back_or_to month_deposits_path, success: '入金額を算出しました'
      else
        redirect_back_or_to month_deposits_path, danger: '条件を設定できませんでした'
      end
    else 
      redirect_back_or_to month_deposits_path, danger: '条件は既に設定されています'
    end
  end

  def destroy
    @deposit = Deposit.find_by(user_id: current_user.id, id: params[:id])
    @deposit.destroy!
    redirect_back_or_to month_deposits_path(@deposit.month_id), success: '削除しました'
  end

  def add_deposit
    authenticate_deposit
    @correct_total_man = Correct.where(user_id: current_user.id, month_id: params[:month_id], player: "旦那").sum(:correct_amount)
    @correct_total_woman = Correct.where(user_id: current_user.id, month_id: params[:month_id], player: "嫁").sum(:correct_amount)
    @corrects = Correct.where(user_id: current_user.id, month_id: params[:month_id]).order(created_at: :asc)
    @correct_man_salary = @deposit.man_salary - @correct_total_man
    @correct_woman_salary = @deposit.woman_salary - @correct_total_woman
    @disposable_income = (@correct_man_salary + @correct_woman_salary - @deposit.total_deposit) / 2
    @disposable_income_man = @disposable_income + @correct_total_man
    @disposable_income_woman = @disposable_income + @correct_total_woman
    @man_deposit = @deposit.man_salary - @disposable_income_man
    @woman_deposit = @deposit.woman_salary - @disposable_income_woman

    @man_detail = Detail.new()
    @man_detail.month_id = params[:month_id]
    @man_detail.user_id = current_user.id
    @man_detail.date = Date.today
    @man_detail.classification = 4
    if @man_deposit > 0
      @man_detail.income = @man_deposit
    else
      @man_detail.spending = @man_deposit
    end
    @man_detail.replayer = "旦那"
    @man_detail.status = 0
    @man_detail.note = "定期入金"

    @woman_detail = Detail.new()
    @woman_detail.month_id = params[:month_id]
    @woman_detail.user_id = current_user.id
    @woman_detail.date = Date.today
    @woman_detail.classification = 4
    if @woman_deposit > 0
      @woman_detail.income = @woman_deposit
    else
      @woman_detail.spending = @woman_deposit
    end
    @woman_detail.replayer = "嫁"
    @woman_detail.status = 0
    @woman_detail.note = "定期入金"

    if @woman_detail.save && @man_detail.save
      redirect_back_or_to month_details_path(params[:month_id]), success: '入金額を反映しました'
    else
      redirect_back_or_to month_deposits_path, danger: '入金額を反映できませんでした'
    end

  end

  private

  def deposit_params
    params.permit(:total_deposit, :man_salary, :woman_salary, :correction1_name, :correction1_amount, :correction1_rate, :correction2_name, :correction2_amount, :correction2_rate, :correction3_name, :correction3_amount, :correction3_rate)
  end

  def authenticate_deposit
    @deposit = Deposit.find_by(user_id: current_user.id, month_id: params[:month_id])
  end

end
