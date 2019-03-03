class User < ApplicationRecord
  USERNAME_REGEX = /\A[a-zA-Z0-9_]+\Z/.freeze
  EMAIL_REGEX = /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})\z/i.freeze
  LINK_VALIDITY = 2.hours
  DEFAULT_LOCALE = "en".freeze
  DEFAULT_PROVIDER = "open-idea-station".freeze

  include UniqueIdentifier

  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }, \
                       format: USERNAME_REGEX
  validates_presence_of :email, :password_digest
  validates :email, uniqueness: { case_sensitive: false }, format: EMAIL_REGEX

  validates :password, presence: true, if: :password
  validates :password, confirmation: { case_sensitive: true }

  has_many :ideas, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.find_user_by_session(token)
    session = Session.find_by(token: token, active: true)
    session&.user
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

  def save
    self.new_email = email

    super
  end

  def send_email_confirmation
    token = Acorn::JsonWebToken.encode({ data: [id, new_email] }, LINK_VALIDITY.from_now)

    UsersMailer.delay.email_confirmation(id, token)
  end

  def uid_prefix
    "usr"
  end

  concerning :Sessions do
    included do
      has_many :sessions, dependent: :destroy
    end

    def all_sessions
      sessions.order(created_at: :desc)
    end

    def find_session!(id)
      # TODO: ids should point to uids in objects
      all_sessions.find_by!(id: id)
    end

    def find_session_by_token(token)
      all_sessions.find_by(token: token)
    end

    def create_session(attributes)
      sessions.create(attributes)
    end

    def revoke_all_sessions!(options = {})
      relation = sessions.active
      relation = relation.where.not(token: options[:except]) if options[:except]
      relation.map(&:revoke!)
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
