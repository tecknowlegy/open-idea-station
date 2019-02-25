module Acorn
  module NotificationBroadcast
    def send_broadcast(recipients, notification_content)
      recipients.each do |recipient|
        ActionCable.server.broadcast(
          "notifications-#{recipient[:recipient]}",
          html: render_notification(notification_content)
        )
      end
    end

    private

    def render_notification(notification)
      ApplicationController.render(
        partial: "layouts/notification",
        locals: { notification: notification }
      )
    end
  end
end
