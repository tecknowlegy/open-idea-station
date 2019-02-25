require "action_view"
require "action_view/helpers"

module Notifiable
  extend ActiveSupport::Concern

  included do
    include ActionView::Helpers::DateHelper
    include Acorn::NotificationBroadcast
    after_create :build_notification
  end

  # Any model that includes this module concern must implement
  # Model#prepare_recipients method which is responsible for
  # the availablility of recipients list
  def build_notification
    return unless respond_to?(:prepare_recipients)

    prepare_recipients.each do |recipient|
      Notification.create(
        recipient: recipient,
        actor: user,
        action: self.class::ACTION.to_s,
        notifiable: self,
        is_read: false
      )

      broadcast_content = {
        actor: user.username,
        topic: idea,
        content: content,
        picture: picture,
        recipient: recipient[:username],
        time: time,
      }

      send_broadcast(broadcast_content)
    end
  end

  private

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
