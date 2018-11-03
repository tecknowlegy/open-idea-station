class AcornService::AuthenticateUserService
  prepend SimpleCommand

  def initialize(user_params)
    @username = user_params[:username]
    @password = user_params[:password]
    @email_regex = /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})\z/i
  end

  def call
    Acorn::JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :username, :password, :email_regex

  def find_email_or_name
    return User.find_by_email(username) if username.match(email_regex)

    User.find_by_username(username)
  end

  def user
    user = find_email_or_name
    return user if user&.authenticate(password)

    errors.add(:user_authentication, "Invalid credentials")
    nil
  end
end
