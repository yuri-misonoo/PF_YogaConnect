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
  end

  def update
  end


  private

  def user_params
    params.require(:user).permit(:profile_image, :goal_weight, :goal, :introduction)
  end

end
