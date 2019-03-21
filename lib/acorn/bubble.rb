module Acorn
  module Bubble
    SECRET_KEY = Rails.application.secrets.secret_key_base
    EXPIRY = User::LINK_VALIDITY.from_now

    module_function

    # Public: generate recieves an array as argument
    def generate(payload, expiry = nil)
      verifier.generate(payload << (expiry.from_now || EXPIRY))
    end

    def verify(token)
      verifier.verified(token)
    end

    def verifier
      ActiveSupport::MessageVerifier.new(SECRET_KEY, digest: "SHA256")
    end
  end
end
