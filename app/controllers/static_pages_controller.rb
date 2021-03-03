class StaticPagesController < ApplicationController
  skip_before_action :require_login
  skip_before_action :authenticated_this_month

  def top;end
  def terms_of_service;end
  def privacy_policy;end
end
