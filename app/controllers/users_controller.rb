class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def index
    User.current_user = current_user
    @who_to_follow = current_user.who_to_follow
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.photo = Faker::Avatar.image(slug: params[:username], size: "100x100", format: "jpg")
    @user.cover_image = Faker::LoremFlickr.image(size: "744x249", search_terms: ['nature'])

    if @user.save
      log_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def search
    @who_to_follow = current_user.who_to_follow
    render partial: 'users/index/who_to_follow'
  end

  def connection
    user = User.find_by(username: params[:username])
    User.current_user = user
    @headline = params[:slug].eql?('following') ? "Your followees" : "Your followers"
    @user_list = params[:slug].eql?('following') ? user.followees.includes(:followed_by_someone_you_follow) : user.followers.includes(:followed_by_someone_you_follow)
    @who_to_follow = user.who_to_follow
  end

  def follow
    Following.create(follower_id: current_user.id, followed_id: params[:id])
    redirect_to user_show_path(slug: User.find(params[:id]).username)
  end
  
  def unfollow
    Following.destroy(Following.where(follower_id: current_user.id, followed_id: params[:id]).first.id)
    redirect_to user_show_path(slug: User.find(params[:id]).username)
  end
  
  def show 
    User.current_user = current_user
    @user = User.find_by(username: params[:slug])
    @posts = @user.microposts
    @who_to_follow = @user.followers.limit(3)
  end

  private

  def user_params
    params.require(:user).permit(:username, :full_name)
  end
end
