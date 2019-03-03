module NotificationsHelper
  def recent_notifications
    @notifications ||= current_user.recent_notifications(10)
  end
end
