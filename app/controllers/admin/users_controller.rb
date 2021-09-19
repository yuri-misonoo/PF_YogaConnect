class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(20)
    #ユーザー登録数のグラフ出力
    #@users_count = User.group_by_day(:created_at).size
    #ユーザーの１日の登録者数
    #@user_today = User.where(created_at: Date.today.all_day).count

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
