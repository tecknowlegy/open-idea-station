# It’s good practice to minimize the business logic contained in job
# classes. Instead, give that responsibility to a model or service class
# that can be well-tested in isolation from the background processing
# machinery.

class NotificationBroadcastJob < ApplicationJob
  include Acorn::NotificationBroadcast

  queue_as :default

  def perform(recipients_list, notification_content)
    send_broadcast(recipients_list, notification_content)
  end
end
