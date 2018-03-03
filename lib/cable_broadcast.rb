module CableBroadcast
  def send_broadcast(content)
    ActionCable.server.broadcast(
      'notifications' + content[:recipient],
      html: render_notification(
        id: content[:id],
        action: content[:action],
        created_at: content[:created_at],
        is_read: false
      )
    )
  end

  private

  def render_notification(notification)
    ApplicationController.render(
      partial: 'layouts/notification',
      locals: { notification: notification }
    )
  end
end
