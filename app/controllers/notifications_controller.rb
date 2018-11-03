class NotificationsController < ApplicationController
  before_action :set_notification

  private

  def set_notification
    @notifications = Notification.where(recipient: current_user).unread
  end
end
