class Notification < ApplicationRecord
  SIZE = 5

  include UniqueIdentifier

  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(is_read: false) }
  scope :recent, ->(size) { limit(size || SIZE) }

  def uid_prefix
    "nof"
  end
end
