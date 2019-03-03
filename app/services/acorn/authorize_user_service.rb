class Acorn::AuthorizeUserService
  prepend SimpleCommand

  def initialize(token)
    @token = token
  end

  def call
    authorized?
  end

  private

  attr_accessor :token

  def authorized?
    decoded_auth_token.present? || errors.add(:token, "Invalid token") && false
  end

  def decoded_auth_token
    @decoded_auth_token ||= Acorn::JsonWebToken.decode(auth_token)
  end

  def auth_token
    if token.present?
      return token.split(" ").last
    else
      errors.add(:token, "No Token was provided")
    end

    nil
  end
end
