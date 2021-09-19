class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    #相手からの通知をうけとる　
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    #未確認のつうちレコードを取り出したあと、未確認から確認済みに更新
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
end
