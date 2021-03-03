class CorrectsController < ApplicationController
  def index
    authenticate_deposit
    @corrects = Correct.where(user_id: current_user.id, deposit_id: params[:deposit_id]).includes(:deposit).order(created_at: :asc)
  end

  def create
    @add = Correct.new(correct_params)
    authenticate_deposit
    @add.rate = 100 if !@add.rate.present?
    @add.correct_amount = @add.amount * @add.rate / 100 if @add.amount.present?
    @add.month_id = @deposit.month_id
    @add.user_id = current_user.id
    @add.deposit_id = params[:deposit_id]
    if @add.save
      redirect_back_or_to deposit_corrects_path, success: '補正明細を追加しました'
    else
      redirect_back_or_to deposit_corrects_path, danger: '補正明細を追加できませんでした'
    end
  end

  def destroy
    authenticate_deposit
    @correct = Correct.find_by(user_id: current_user.id, id: params[:id])
    @correct.destroy!
    redirect_back_or_to deposit_corrects_path(@correct.deposit_id), success: '削除しました'
  end

  private

  def correct_params
    params.permit(:name, :player, :amount, :rate)
  end

  def authenticate_deposit
    @deposit = Deposit.find_by(user_id: current_user.id, id: params[:deposit_id])
  end

  def authenticate_correct
    @correct = Correct.find_by(user_id: current_user.id, month_id: params[:month_id])
  end

end
