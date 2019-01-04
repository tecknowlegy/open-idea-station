class Acorn::AuthenticateUserService
  prepend SimpleCommand

  def initialize(params)
    @username = params[:username]
    @password = params[:password]
    @session_params = params.except(:username, :password)
  end

  def call
    session = user&.create_session(
      session_params.merge(
        token: Acorn::JsonWebToken.encode({ user_id: user.id }, expires_at),
        expires_at: expires_at,
        active: true
      )
    )

    session&.token
  end

  private

  attr_accessor :username, :password, :email_regex, :session_params

  def find_email_or_name
    return User.find_by_email(username) if username.match(User::EMAIL_REGEX)

    User.find_by_username(username)
  end

  def user
    user = find_email_or_name
    return user if user&.authenticate(password)

    errors.add(:user_authentication, "Invalid credentials")
    nil
  end

  def expires_at
    Session::DEVICE_PLATFORMS[@session_params[:device_platform].to_s.to_sym].from_now if Session::DEVICE_PLATFORMS.key?(@session_params[:device_platform].to_s.to_sym)
  end
end
