class MicropostsController < ApplicationController
  def create
    post = Micropost.create(author_id: current_user.id, text: params[:micropost][:text])

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
end
