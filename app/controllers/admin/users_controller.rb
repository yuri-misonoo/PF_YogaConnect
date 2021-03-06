class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.search(params[:search]).order(created_at: :desc).page(params[:page]).per(20)
    @users_count = User.group_by_day(:created_at).size
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
      redirect_to admin_user_path(@user), notice: 'ユーザー情報を編集しました'
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
