class NotificationsController < ApplicationController
  before_action :set_notification, only: :destroy
  after_action :show, :mark_as_read
  after_action :index, :mark_as_read

  def index
    @notifications = current_user.all_notifications
  end

  def show
    @notifications = current_user.recent_notifications(params[:size])
  end

  def mark_as_read
    @notifications.update_all(is_read: true, updated_at: DateTime.now)
  end

  def destroy
    @notification.destroy
  end

  def destroy_all
    current_user.all_notifications.destroy_all
  end

  private

  def set_notification
    @notification = current_user.find_notification!(params[:id].to_s)

  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "This notification has already been deleted"
  end
end
