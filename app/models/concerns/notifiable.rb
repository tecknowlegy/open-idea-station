module Notifiable
  extend ActiveSupport::Concern

  included do
    include CableBroadcast
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

      # stream_content = {
      #   id: id,
      #   recipient: recipient[:username],
      #   action: "#{user[:username]} commented on #{idea[:name]}",
      # }
      # send_broadcast(stream_content)
    end
  end
end
