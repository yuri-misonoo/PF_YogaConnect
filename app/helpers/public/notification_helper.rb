module Public::NotificationHelper
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
