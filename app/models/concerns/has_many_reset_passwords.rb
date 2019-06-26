module HasManyResetPasswords
  extend ActiveSupport::Concern

  included do
    has_many :reset_passwords, dependent: :destroy
  end

  def all_reset_passwords
    reset_passwords.order(created_at: :desc)
  end

  def find_reset_password_by_token(token)
    all_reset_passwords.find_by(token: token)
  end

  def change_password(password_attributes)
    if update(password_attributes.merge({ password_changed_at: Time.zone.now }))
      all_reset_passwords.each(&:destroy)
      true
    else
      false
    end
  end

  def send_reset_password_email
    token = Acorn::Bubble.generate([id, email], RESET_LINK_VALIDITY)
    reset_passwords.create(token: token)

    UsersMailer.reset_password(id, token).deliver_later
  end

  def send_reset_password_success_mail
    true
  end
end
