class GuestSessionsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :authenticated_this_month

  def create
    user = User.find_by(email: 'oretokuguestuser@example.com')
    log_in(user)
    redirect_to user_path(user), success: 'ゲストユーザーでログインしました'
  end
end
