class Notification < ApplicationRecord
  SIZE = 5

  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }
  scope :recent, ->(size) { limit(size || SIZE) }
end
