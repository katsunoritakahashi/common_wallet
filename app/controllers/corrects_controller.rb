class CorrectsController < ApplicationController
  def index
    authenticate_correct
    #binding.irb
    @corrects = Correct.where(user_id: current_user.id, month_id: params[:month_id]).order(created_at: :asc)
  end

  def create
    @add = Correct.new(correct_params)
    authenticate_correct
    @add.rate = 100 if !@add.rate.present?
    @add.correct_amount = @add.amount * @add.rate / 100 if @add.amount.present?
    @add.month_id = params[:month_id]
    @add.user_id = current_user.id
    #binding.irb
    if @add.save
      redirect_back_or_to month_deposits_path(@add.month_id), success: '補正明細を追加しました'
    else
      redirect_back_or_to month_corrects_path, danger: '補正明細を追加できませんでした'
    end
  end

  def destroy
    authenticate_correct
    @correct = Correct.find_by(user_id: current_user.id, id: params[:id])
    @correct.destroy!
    redirect_back_or_to month_deposits_path(@correct.month_id), success: '削除しました'
  end

  private

  def correct_params
    params.permit(:name, :player, :amount, :rate)
  end

  def authenticate_correct
    @correct = Correct.find_by(user_id: current_user.id, month_id: params[:month_id])
  end
end
