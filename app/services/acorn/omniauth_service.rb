class Acorn::OmniauthService
  prepend SimpleCommand

  def initialize(omniauth_hash:)
    @omniauth_hash = omniauth_hash
  end

  def call
    omniauth_user
  end

  private

  attr_reader :omniauth_hash

  def omniauth_user
    if omniauth_hash.present?
      user = User.find_by(email: omniauth_hash.info.email)

      if user.present?
        returning_user
      else
        new_user
      end
    else
      errors.add(:omniauth_error, "User credential was not provided by external service")
    end
  rescue StandardError
    errors.add(:omniauth_error, "An error occurred when trying to read omniuth data")
  end

  def returning_user
    user.update(
      provider: omniauth_hash.provider || user.provider,
      picture: omniauth_hash.extra["raw_info"]&.avatar_url || omniauth_hash.info.image
    )

    [user, "session"]
  end

  def new_user
    # else use normal create flow
    user =  case omniauth_hash.provider
            when "google_oauth2"
              User.new do |u|
                u.provider = omniauth_hash.provider
                u.username = omniauth_hash.info.first_name unless omniauth_hash.info.first_name.nil?
                u.email    = omniauth_hash.info.email
                u.picture  = omniauth_hash.info.image
              end
            when "github"
              User.new do |u|
                u.provider = omniauth_hash.provider
                u.username = omniauth_hash.extra["raw_info"].login unless omniauth_hash.extra["raw_info"]&.login.nil?
                u.email    = omniauth_hash.extra["raw_info"].email unless omniauth_hash.extra["raw_info"]&.email.nil?
                u.picture  = omniauth_hash.extra["raw_info"].avatar_url unless omniauth_hash.extra["raw_info"]&.avatar_url.nil?
              end
            end

    [user, "new"]
  end
end
