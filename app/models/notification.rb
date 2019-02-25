class Notification < ApplicationRecord
  SIZE = 5

  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(is_read: false) }
  scope :recent, ->(size) { limit(size || SIZE) }
end
