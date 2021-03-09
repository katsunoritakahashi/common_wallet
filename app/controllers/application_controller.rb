class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :authenticated_this_month

  private

  def not_authenticated
    flash[:warning] = 'ログインして下さい'
    redirect_to login_path
  end

  def authenticated_this_month
    @authenticated_this_month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
