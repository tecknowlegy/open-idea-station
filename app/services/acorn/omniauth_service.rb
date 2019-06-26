class Acorn::OmniauthService
  prepend SimpleCommand

  def initialize(omniauth_hash:)
    @omniauth_hash = omniauth_hash
    @user = nil
  end

  def call
    omniauth_user
  end

  private

  attr_reader :omniauth_hash, :user

  def omniauth_user
    if omniauth_hash.present?
      @user = User.find_by(email: omniauth_hash.info.email)

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
    @user.update(
      provider: omniauth_hash.provider || user.provider,
      picture: omniauth_hash.extra["raw_info"]&.avatar_url || omniauth_hash.info.image
    )

    [user, "session"]
  end

  def new_user
    # else use normal create flow
    @user = case omniauth_hash.provider
            when "google_oauth2"
              Acorn::OmniauthService::GoogleUser.new(omniauth_hash).data
            when "github"
              Acorn::OmniauthService::GithubUser.new(omniauth_hash).data
            end

    [user, "new"]
  end

  # The class and it's subclasses define how we want to extract omniauth info
  # based on the provider
  class UserPayload
    attr_reader :provider, :username, :email, :picture

    def initialize(payload)
      @provider = payload.provider
      @username = payload.username
      @email    = payload.email
      @picture  = payload.picture
    end

    def data
      User.new do |u|
        u.provider = provider
        u.username = username
        u.email    = email
        u.picture  = picture
      end
    end
  end

  class GoogleUser < UserPayload
    def initialize(payload)
      @provider = payload.provider
      @username = payload.info.first_name unless payload.info.first_name.nil?
      @email    = payload.info.email
      @picture  = payload.info.image
    end
  end

  class GithubUser < UserPayload
    def initialize(payload)
      @provider = payload.provider
      @username = payload.extra["raw_info"].login unless payload.extra["raw_info"]&.login.nil?
      @email    = payload.extra["raw_info"].email unless payload.extra["raw_info"]&.email.nil?
      @picture  = payload.extra["raw_info"].avatar_url unless payload.extra["raw_info"]&.avatar_url.nil?
    end
  end
end
