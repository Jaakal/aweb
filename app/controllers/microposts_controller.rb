class MicropostsController < ApplicationController
  def create
    post = current_user.microposts.create(micropost_params)

    if post.valid?
      @posts = current_user.all_the_posts_for_timeline
      render partial: 'microposts/posts'
    else
      @error = post.errors.messages[:text].first
      render partial: 'microposts/error'
    end
  end

  def user_posts
    user = User.find_by(username: params[:slug])
    @posts = user.microposts
    render partial: 'microposts/posts'
  end

  def all_posts
    @posts = current_user.microposts
    render partial: 'microposts/posts'
  end

  private

  def micropost_params
    params.require(:micropost).permit(:text)
  end
end
