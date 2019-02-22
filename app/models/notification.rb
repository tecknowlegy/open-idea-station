class Notification < ApplicationRecord
  SIZE = 5
  ACTIONS = %i[liked commented viewed]

  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(is_read: false) }
  scope :recent, ->(size) { limit(size || SIZE) }

  def mark_all_as_read
    update_all(read_at: Time.zone.now)
  end
end
