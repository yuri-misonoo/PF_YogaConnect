class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to posts_path, notice: '仲間とともにヨガを楽しみましょう！'
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :goal_weight, :goal)
  end

end
