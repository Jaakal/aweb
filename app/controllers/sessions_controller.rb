class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    @user = User.find_by(username: login_params[:username])
    if @user
      User.current_user = @user
      log_in @user
      redirect_to root_path
    else
      flash.notice = 'Invalid username'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private

  def login_params
    params.require(:session).permit(:username)
  end
end
