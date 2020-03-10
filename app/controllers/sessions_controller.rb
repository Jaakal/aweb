class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user
      User.current_user = @user
      log_in @user
      # redirect_to user_show_path(slug: @user.username)
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid username'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
