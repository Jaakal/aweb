class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def index
    User.who_to_follow_offset = 0
    @user = current_user
    @who_to_follow = @user.who_to_follow
    @followers = @user.followers.count
    @followed = @user.followed.count
  end

  def search
    User.who_to_follow_offset += 3
    @who_to_follow = current_user.who_to_follow
    render partial: 'layouts/who_to_follow'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.photo = Faker::Avatar.image(slug: params[:username], size: "100x100", format: "jpg")
    @user.cover_image = Faker::LoremFlickr.image(size: "1760x590", search_terms: ['nature'])

    if @user.save
      log_in @user
      flash[:success] = 'You have created an account!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(username: params[:slug])
  end

  private

  def user_params
    params.require(:user).permit(:username, :full_name)
  end
end
