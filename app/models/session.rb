class Session < ApplicationRecord
  # include UniqueIdentifier

  # Device platforms:
  # Key = platform type
  # Value = for how long the session can be used (even if inactive)
  DEVICE_PLATFORMS = {
    mobile_app: 1.month,
    shared_computer: 1.hour,
    browser: 8.hours,
    "": 8.hours,
  }.freeze

  belongs_to :user

  validates :ip_address, :user_agent, :device_platform, :location, length: { maximum: 255 }
  validates_inclusion_of :device_platform, in: DEVICE_PLATFORMS.keys.map(&:to_s), allow_nil: true

  scope :active, -> { where(active: true).where("expires_at > ?", Time.zone.now) }
  scope :inactive, -> { where("active = false OR expires_at <= ?", Time.zone.now) }

  def revoke!
    update active: false
  end

  def renew!
    update active: true
  end
end
