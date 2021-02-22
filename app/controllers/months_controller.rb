class MonthsController < ApplicationController
  def index
    @months = Month.where(user_id: current_user.id).includes(:user).order(month: :asc)
    @month = Month.new
    
    #binding.irb
  end

  def new
  end

  def create
    @month = Month.new(month_params)
    #binding.irb
    @month.user_id = current_user.id
    #binding.irb
    if @month.save
      redirect_back_or_to months_path, success: '追加しました'
    else
      flash.now[:danger] = '追加できませんでした'
      render :index
    end
  end

  def destroy
    @month = current_user.months.find(params[:id])
    @month.destroy!
    redirect_to months_path
  end

  def show
  end

  private

  def month_params
    params.require(:month).permit(:month)
  end
end
