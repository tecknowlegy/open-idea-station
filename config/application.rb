require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Acorns
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # Paths to load in production which are normally supported by rails
    all_autoload_paths = [
      Rails.root.join("lib"),
      Rails.root.join("lib", "acorn"),
    ]

    # change the default behavior for rescuing forbidden server response
    config.action_dispatch.rescue_responses["IdeasController::Forbidden"] = :forbidden

    # provide global access to /lib directory
    config.autoload_paths += all_autoload_paths
    # In production, it relies on eager_load_paths to load the modules
    config.eager_load_paths += all_autoload_paths

    config.time_zone = "West Central Africa"
    config.i18n.default_locale = :en
    config.i18n.available_locales = %i[en]
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.yml").to_s]

    # default background processing
    # when app grows bigger consider this:
    # https://github.com/mperham/sidekiq/wiki/Active+Job#performance
    config.active_job.queue_adapter = :sidekiq

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.helper false
      g.assets false
      g.view_specs false
      g.helper_specs false
      g.routing_specs false
      g.controller_specs false
      g.test_framework :rspec, fixture: false
      g.template_engine :haml
    end
  end
end
