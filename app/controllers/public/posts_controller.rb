class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿に成功しました'
    else
      flash.now[:alert] = '投稿は10文字以上入力してください'
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)

    # フォローしているユーザーのidを取得
    # folllowing_users = current_user.followings.pluck(:id)
    # 自身のidを一覧に追加する
    # folllowing_users.push(current_user.id)
    # @posts = Post.where(user_id: folllowing_users).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿内容を編集しました'
    else
      flash.now[:alert] = '投稿は10文字以上入力してください'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました'
  end

  def search
    # viewのformで受け取ったパラメータをモデルに渡す
    @posts = Post.search(params[:search]).order(created_at: :desc)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
