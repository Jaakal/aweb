class ApplicationController < ActionController::Base
  include SessionsHelper
  
  protect_from_forgery with: :exception
  before_action :authorized

  private

  def authorized
    redirect_to login_path unless logged_in?
  end
end
