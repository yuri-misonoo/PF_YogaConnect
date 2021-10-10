class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 相手からの通知をうけとる
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    # 通知の確認未確認の切り替え。モデルに定義
    @notifications.check!
  end
end
