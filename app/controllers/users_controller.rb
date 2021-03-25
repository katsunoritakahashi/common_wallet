class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create edit update]
  skip_before_action :authenticated_this_month, only: %i[new destroy create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_back_or_to months_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録ができませんでした'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
