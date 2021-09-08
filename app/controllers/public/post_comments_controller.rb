class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    body = current_user.post_comments.new(post_comment_params)
    body.post_id = post.id
    body.save
    redirect_to post_path(post)
  end

  def destory
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:body)
  end
  
end
