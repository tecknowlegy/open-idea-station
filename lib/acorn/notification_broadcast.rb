module Acorn
  module NotificationBroadcast
    def send_broadcast(content)
      ActionCable.server.broadcast(
        "notifications-" + content[:recipient],
        html: render_notification(content.except(:recipient))
      )
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
