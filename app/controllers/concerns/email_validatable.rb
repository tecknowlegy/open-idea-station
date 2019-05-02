module EmailValidatable
  extend ActiveSupport::Concern

  private

  # Usage: `valid_email email`
  # this returns true or false for email validity
  def valid_email(email)
    email.present? && email.match(User::EMAIL_REGEX)
  end
end
