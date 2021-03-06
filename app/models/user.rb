class User < ApplicationRecord
  USERNAME_REGEX = /\A[a-zA-Z0-9_]+\Z/.freeze
  EMAIL_REGEX = /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})\z/i.freeze
  LINK_VALIDITY = 2.hours
  RESET_LINK_VALIDITY = 1.hour
  DEFAULT_LOCALE = "en".freeze
  DEFAULT_PROVIDER = "open-idea-station".freeze

  include UniqueIdentifier
  include HasManySessions
  include HasManyResetPasswords

  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }, \
                       format: USERNAME_REGEX
  validates_presence_of :email, :password_digest
  validates :email, uniqueness: { case_sensitive: false }, format: EMAIL_REGEX

  validates :password, presence: true, if: :password, length: { within: 6..40 }
  validates :password, confirmation: { case_sensitive: true }

  has_many :ideas, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.find_user_by_session(token)
    session = Session.find_by(token: token, active: true)
    session&.user
  end

  def self.find_by_email_token(token, purpose)
    return nil unless token.present?

    id, email, expiry = Acorn::Bubble.verify(token)

    return nil unless expiry.present? && expiry > Time.now

    if purpose.to_sym == :email_confirmation
      find_by(id: id, new_email: email)
    else
      find_by(id: id, email: email)
    end
  end

  def self.find_reset_password_token(token, purpose)
    user = find_by_email_token(token, purpose)

    return nil unless user.find_reset_password_by_token(token).present?

    user
  end

  def uid_prefix
    "usr"
  end

  def bio
    read_attribute(:bio) || "Bio is yet to be updated"
  end

  def provider
    read_attribute(:provider) || DEFAULT_PROVIDER
  end

  def locale
    read_attribute(:locale) || DEFAULT_LOCALE
  end

  def locale=(locale)
    write_attribute(:locale, locale)
    save
  end

  def created?
    self.email = Acorn::Normalize.email(email)
    self.new_email = email
    save
  end

  concerning :EmailConfirmations do
    def send_email_confirmation
      token = Acorn::Bubble.generate([id, new_email])

      UsersMailer.email_confirmation(id, token).deliver_later
    end

    def confirm_email
      self.email = new_email unless new_email.blank?
      self.email_confirmed = true
      self.new_email = nil
      save
    end
  end

  concerning :Notifications do
    included do
      has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
    end

    def all_notifications
      notifications.order(created_at: :desc)
    end

    def unread_notifications
      all_notifications.unread
    end

    def recent_notifications(size = nil)
      all_notifications.recent(size)
    end

    def find_notification!(id)
      all_notifications.find_by!(id: id)
    end
  end
end
