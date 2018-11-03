class Comment < ApplicationRecord
  include CableBroadcast

  belongs_to :idea
  belongs_to :user

  after_create :create_notification

  def prepare_recipients
    idea_commenters = []
    Idea.find_by(id: idea_id).comments.each do |commenter|
      idea_commenters.push(User.find_by(id: commenter[:user_id]))
    end
    recipients = idea_commenters.uniq - [user]
  end

  def create_notification
    prepare_recipients.each do |recipient|
      Notification.create(recipient: recipient, actor: user,
                          action: "commented", notifiable: self, is_read: false)

      stream_content = {
        id: id,
        recipient: recipient[:username],
        action: "#{user[:username]} commented on #{idea[:name]}",
      }
      # send_broadcast(stream_content)
    end
  end
end
