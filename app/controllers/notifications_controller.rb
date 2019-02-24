class NotificationsController < ApplicationController
  after_action :mark_as_read, only: %i[index update]
  before_action :set_notification, only: :destroy
  before_action :set_user, only: :update

  # Handles rendering of all notifactions "views/notifications/index"
  def index
    @notifications ||= current_user.all_notifications
  end

  # Handles updating user notification badge - unread
  def show
    @notifications = current_user.recent_notifications
    render json: { data: @notifications, has_unread: unread?(@notifications) }
  end

  # Handles updating user notification badge - read
  def update
    @notifications = @user.recent_notifications(params[:size])
    render json: { data: "status-read" }
  end

  def destroy
    @notification.destroy
  end

  def destroy_all
    current_user.all_notifications.destroy_all
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id].to_s)
  end

  def mark_as_read
    @notifications.update_all(is_read: true, updated_at: DateTime.now)
  end

  def unread?(notifs)
    notifs.each do |notif|
      return true unless notif.is_read
    end
    false
  end

  def set_notification
    @notification = current_user.find_notification!(params[:id].to_s)

  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "This notification does not exist or has already been deleted"
  end
end
