class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(20)
    #ユーザー登録数のグラフ出力
    #@users_count = User.group_by_day(:created_at).size
    #ユーザーの１日の登録者数
    #@user_today = User.where(created_at: Date.today.all_day).count

  end


end
