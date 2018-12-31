class Acorn::AuthorizeUserService
  prepend SimpleCommand

  def initialize(token)
    @token = token
  end

  def call
    user
  end

  private

  attr_accessor :token

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, "Invalid token") && nil
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
