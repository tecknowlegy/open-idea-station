OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['ACORN_GOOGLE_CLIENT_ID'], ENV['ACORN_GOOGLE_SECRET'],
  {
    client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}
  }
  provider :facebook, ENV['ACORN_FACEBOOK_APP_ID'], ENV['ACORN_FACEBOOK_SECRET'],
  {
    client_options: {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}
  }
end