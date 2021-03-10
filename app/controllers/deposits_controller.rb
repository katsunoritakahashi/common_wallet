class DepositsController < ApplicationController
  def index
    @month = Month.find_by(user_id: current_user.id, id: params[:month_id])
    authenticate_budget
    @correct_total_man = Correct.where(user_id: current_user.id, month_id: params[:month_id], player: "旦那").sum(:correct_amount)
    @correct_total_woman = Correct.where(user_id: current_user.id, month_id: params[:month_id], player: "嫁").sum(:correct_amount)
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
    if !authenticate_budget
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

  private

  def deposit_params
    params.permit(:total_deposit, :man_salary, :woman_salary, :correction1_name, :correction1_amount, :correction1_rate, :correction2_name, :correction2_amount, :correction2_rate, :correction3_name, :correction3_amount, :correction3_rate)
  end

  def authenticate_budget
    @deposit = Deposit.find_by(user_id: current_user.id, month_id: params[:month_id])
  end

end
