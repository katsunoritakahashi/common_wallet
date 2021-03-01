class ApplicationController < ActionController::Base
  before_action :require_login #sorceryが作成するメソッド。ログインしてない時not_authenticatedメソッドを発火する
  before_action :authenticated_this_month

  private

  def not_authenticated
    flash[:warning] = 'ログインして下さい'
    redirect_to login_path
  end

  def authenticated_this_month
    @authenticated_this_month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
  end
end
