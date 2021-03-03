class MonthsController < ApplicationController
  def index
    @months = Month.where(user_id: current_user.id).includes(:user).order(month: :desc)
    @month = Month.new
    @column_chart = Month.where(user_id: current_user.id).includes(:user).order(month: :asc).last(7).pluck(:month, :balance_last)
  end

  def new
  end

  def create
    @month = Month.new(month_params)
    @data = Month.find_by(user_id: current_user.id, month: @month.month)
    @month.balance_last = @month.balance
    if !@data.present?
      @month.user_id = current_user.id
      if @month.save
        redirect_back_or_to months_path, success: '家計簿を追加しました'
      else
        redirect_back_or_to months_path, danger: '追加できませんでした'
      end
    else
      redirect_back_or_to months_path, danger: '同じ月は追加できません'
    end
  end

  def edit
    each_month
  end

  def update
    each_month
    each_total
    @month.update(month_params)
    @month.balance_last = @month.balance + @balance_of_payments
    if @month.save
      redirect_back_or_to months_path, success: '月初残高を修正しました'
    else
      redirect_back_or_to edit_month_path, danger: '修正できませんでした'
    end
  end

  def destroy
    @month = current_user.months.find(params[:id])
    @month.destroy!
    #redirect_to months_path
  end

  def show
  end

  private

  def month_params
    params.require(:month).permit(:month, :balance)
  end

  def each_month
    @month = Month.find_by(user_id: current_user.id, id: params[:id])
  end

  def each_total
    @income_total = Detail.where(user_id: current_user.id, month_id: params[:id]).includes(:user).sum(:income)
    @spending_total = Detail.where(user_id: current_user.id, month_id: params[:id]).includes(:user).sum(:spending)
    @balance_of_payments = @income_total - @spending_total
  end
end
