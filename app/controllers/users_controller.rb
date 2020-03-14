class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[new create]

  def index
    User.who_to_follow_offset = 0
    User.current_user = current_user
    @posts = current_user.all_the_posts_for_timeline
    @who_to_follow = current_user.who_to_follow
  end

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.photo = Faker::Avatar.image(slug: params[:username], size: '100x100', format: 'jpg')
    @user.cover_image = Faker::LoremFlickr.image(size: '744x249', search_terms: ['nature'])

    if @user.save
      log_in @user
      redirect_to root_path
    else
      @user.username = @user.full_name = ''
      render 'new'
    end
  end

  def search
    User.who_to_follow_offset += 3
    @who_to_follow = current_user.who_to_follow
    render partial: 'users/index/who_to_follow'
  end

  def connection
    user = User.find_by(username: params[:username])
    User.current_user = user
    @headline = headline(user, params[:slug])

    if @headline.nil?
      redirect_to root_path
    else
      @user_list = user_list(user, params[:slug])
      @who_to_follow = user.who_to_follow
      render partial: 'users/connection/user_list'
    end
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
