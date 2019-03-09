require "action_view"
require "action_view/helpers"

module Notifiable
  extend ActiveSupport::Concern

  included do
    include ActionView::Helpers::DateHelper
    after_create :build_notification
  end

  # Any model that includes this module concern must implement
  # Model#prepare_recipients method which is responsible for
  # the availablility of recipients list
  def build_notification
    return unless respond_to?(:prepare_recipients)

    recipients = []

    prepare_recipients.each do |recipient|
      Notification.create(
        recipient: recipient,
        actor: user,
        action: self.class::ACTION.to_s,
        notifiable: self,
        is_read: false
      )

      recipients << { recipient: recipient[:username] }
    end

    ::NotificationBroadcastJob.perform_later(recipients, broadcast_content)
  end

  private

  def broadcast_content
    {
      actor: user.username,
      topic: idea,
      content: content,
      picture: picture,
      time: time,
    }
  end

  def content
    case self.class::ACTION.to_s
    when "commented" then "commented on #{idea.name}"
    else
      "#{self.class::ACTION} #{idea.name}"
    end
  end

  def picture
    user.picture || "dummy-profile-male.jpg"
  end

  def time
    "#{time_ago_in_words(created_at)} ago"
  end
end
