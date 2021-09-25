class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.search(params[:search]).order(created_at: :desc)
  end

  def destroy
    # @post = Post.find(params[:post_id])
    # @post_comment = @post.post_comments.find(params[:id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_posts_path, notice: 'コメントを削除しました'
  end

end
