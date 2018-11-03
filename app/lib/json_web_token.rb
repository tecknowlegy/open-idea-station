class JsonWebToken
  class << self
    HMAC_SECRET = Rails.application.secrets.secret_key_base

    def encode(payload, exp = 12.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, HMAC_SECRET)
    end

    def decode(token)
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body

    # rescue JWT::DecodeError => e
    #   raise ExceptionHandler::InvalidToken, e.message
    # end
    rescue StandardError
      nil
    end
  end
end
