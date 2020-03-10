class MicropostsController < ApplicationController
  def create
    Micropost.create(author_id: current_user.id, text: params[:micropost][:text])
    head 200, content_type: "text/html"
  end
  
  def show
    @posts = current_user.all_the_posts_for_timeline
    render partial: 'layouts/posts'
  end
end
