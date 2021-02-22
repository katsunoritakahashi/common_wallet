class ApplicationController < ActionController::Base
  before_action :require_login #sorceryが作成するメソッド。ログインしてない時not_authenticatedメソッドを発火する

  private

  def not_authenticated
    flash[:warning] = 'ログインして下さい'
    redirect_to login_path
  end
end
