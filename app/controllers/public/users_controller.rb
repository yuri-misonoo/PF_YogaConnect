class Public::UsersController < ApplicationController
  before_action :authenticate_user!

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
  
  def search
    #viewのformで受け取ったパラメータをモデルに渡す
    @users = User.search(params[:search])
  end


  private

  def user_params
    params.require(:user).permit(:profile_image, :goal_weight, :goal, :introduction, :name)
  end

end
