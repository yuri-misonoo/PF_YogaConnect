class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿に成功しました！'
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: '投稿内容を編集しました'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
