class Acorn::JsonWebToken
  class << self
    HMAC_SECRET = Rails.application.secrets.secret_key_base

    def encode(payload, exp)
      payload[:exp] = exp.to_i
      JWT.encode(payload, HMAC_SECRET)
    end

    def decode(token)
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body

    # rescue JWT::DecodeError => e
    #   raise AcornError::InvalidToken, e.message
    #   nil
    # end

    # rescue JWT::ExpiredSignature
    #   # Handle expired token, e.g. logout user or deny access
    # end
    rescue StandardError
      nil
    end
  end
end
