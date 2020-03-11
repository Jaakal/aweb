class MicropostsController < ApplicationController
  def create
    post = Micropost.create(author_id: current_user.id, text: params[:micropost][:text])
    flash.notice = post.errors.messages[:text] unless post.valid?
    redirect_to root_path
  end

  def show
    @posts = current_user.all_the_posts_for_timeline
    render partial: 'microposts/posts'
  end
end
