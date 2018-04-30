OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['ACORN_GOOGLE_CLIENT_ID'], ENV['ACORN_GOOGLE_SECRET'],
  {
    client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}
  }
  provider :github, ENV['ACORN_GITHUB_KEY'], ENV['ACORN_GITHUB_SECRET'],
  {
    client_options: {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}
  }
end