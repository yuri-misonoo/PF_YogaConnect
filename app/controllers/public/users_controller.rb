class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :unsubscribe, :withdraw]

  def new
    @user = User.find(params[:id])
  end

  def create
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to posts_path, notice: '仲間とともにヨガを楽しみましょう！'
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
    # その日の今日の記録を取得。Time.current.at_beginning_of_day..Time.current.at_end_of_dayで一日（範囲）を
    @today_health_log = HealthLog.find_by(user_id: current_user.id, created_at: Time.current.at_beginning_of_day..Time.current.at_end_of_day)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'ユーザー情報を編集しました'
    end
  end
  
  def favorite
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = User.find(params[:id])
    # is_deletedカラムをfalseにする
    @user.update(is_deleted: true)
    # ログアウトさせる
    reset_session
    redirect_to root_path
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :goal_weight, :goal, :introduction, :name, :link)
  end
end
