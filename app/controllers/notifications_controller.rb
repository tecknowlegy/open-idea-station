class NotificationsController < ApplicationController
  before_action :set_notification, only: :destroy
  after_action :mark_as_read, only: :show
  after_action :mark_as_read, only: :index

  def index
    @notifications ||= current_user.all_notifications
  end

  def show
    @notifications = current_user.recent_notifications

    render json: { data: @notifications, has_unread: unread?(@notifications) }
  end

  def mark_as_read
    @notifications.update_all(is_read: true, updated_at: DateTime.now)
  end

  def mark_as_read_js
    @notifications = current_js_user.recent_notifications(params[:size])
    @notifications.update_all(is_read: true, updated_at: DateTime.now)

    render json: { data: "status-read" }
  end

  def destroy
    @notification.destroy
  end

  def destroy_all
    current_user.all_notifications.destroy_all
  end

  private

  def current_js_user
    User.find_by(id: params[:id].to_s)
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
    flash[:notice] = "This notification has already been deleted"
  end
end
