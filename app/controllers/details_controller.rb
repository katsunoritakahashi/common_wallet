class DetailsController < ApplicationController
  before_action :each_month, only: %i[index reimbursement]
  before_action :each_total, only: %i[index reimbursement]
  before_action :adjust_balance_last, only: %i[index reimbursement]

  def new
    @detail = Detail.new
  end

  def index
    @details = Detail.where(user_id: current_user.id, month_id: params[:month_id]).includes(:month).order(date: :asc)
  end

  def edit
    @detail = Detail.find_by(user_id: current_user.id, id: params[:id])
  end

  def create
    @add = Detail.new(detail_params)
    @add.month_id = params[:month_id]
    @add.user_id = current_user.id
    @add.replayer = "共通" if @add.replayer.blank?
    @add.status = :not_yet
    @add.status = :done if @add.replayer == "共通"
    if @add.date.present? && @add.date >= each_month.month && @add.date < each_month.month.next_month && @add.save
      each_month
      each_total
      @month.balance_last = @month.balance + @balance_of_payments
      @month.save
      @details = Detail.where(user_id: current_user.id, month_id: params[:month_id]).includes(:month).order(date: :asc)
      redirect_back_or_to month_details_path, success: '明細を追加しました。'
    else
      redirect_back_or_to new_month_detail_path, danger: '明細を追加出来ませんでした'
    end
  end

  def update
    @detail = Detail.find_by(user_id: current_user.id, id: params[:id])
    if @detail.status == 'not_yet'
      @detail.status = :done
    elsif @detail.status == 'done'
      @detail.status = :not_yet
    else
      @detail.status = :not_yet
    end
    @detail.save
    begin
      if detail_params_edit
        @detail.update(detail_params_edit) 
        if @detail.replayer == "共通"
          @detail.status = :done
        else
          @detail.status = :not_yet
        end
        @detail.save
        redirect_back_or_to month_details_path(@detail.month_id), success: '明細を編集しました'
      end
    rescue
    end
  end

  def destroy
    @detail = Detail.find_by(user_id: current_user.id, id: params[:id])
    @detail.destroy!
    redirect_back_or_to month_details_path(@detail.month_id), success: '削除しました'
  end

  def reimbursement
    @replayers = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').group(:replayer)
    @details = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').includes(:month).order(date: :asc)
  end

  private

  def detail_params
    params.permit(:date, :classification, :income, :spending, :replayer, :note)
  end

  def detail_params_edit
    params.require(:detail).permit(:date, :classification, :income, :spending, :replayer, :note)
  end

  def each_month
    @month = Month.find_by(user_id: current_user.id, id: params[:month_id])
  end

  def each_total
    @income_total = Detail.where(user_id: current_user.id, month_id: params[:month_id]).includes(:month).sum(:income)
    @spending_total = Detail.where(user_id: current_user.id, month_id: params[:month_id]).includes(:month).sum(:spending)
    @income_total_done_before_today = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :done).where("date <= ?", Date.today).includes(:month).sum(:income)
    @spending_total_done_before_today = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :done).where("date <= ?", Date.today).includes(:month).sum(:spending)
    @balance_of_payments = @income_total - @spending_total
    @balance_of_payments_done_before_today = @income_total_done_before_today - @spending_total_done_before_today
    @income_total_not_common = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').includes(:month).sum(:income)
    @spending_total_not_common = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :not_yet).where("date <= ?", Date.today).where.not(replayer: '共通').includes(:month).sum(:spending)
    @balance_of_payments_not_common = @income_total_not_common - @spending_total_not_common
    @done_income = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :done).sum(:income)
    @done_spending = Detail.where(user_id: current_user.id, month_id: params[:month_id], status: :done).sum(:spending)
  end

  def adjust_balance_last
    @month = Month.find_by(user_id: current_user.id, id: params[:month_id])
    @month.balance_last = @month.balance + @balance_of_payments_done_before_today
    @month.save
  end
end
