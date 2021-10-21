class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :authenticated_this_month

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to profile_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_back_or_to root_path
  end

  def invite_resister
    logout
    redirect_back_or_to new_user_path
  end
end
