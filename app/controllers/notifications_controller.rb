class NotificationsController < ApplicationController

  def index
    @notifications = current_user.unread_notifications
  end
end
