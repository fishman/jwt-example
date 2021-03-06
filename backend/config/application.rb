require_relative 'boot'

# require 'rails/all'
require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

require "action_dispatch/middleware/flash"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.api_only = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.autoload_paths << Rails.root.join('app/graph')
    config.autoload_paths << Rails.root.join('app/graph/utils')
    config.autoload_paths << Rails.root.join('app/graph/mutations')
    config.autoload_paths << Rails.root.join('app/graph/types')

    config.grpc_server = 'localhost:50051'
    config.rest_greeter = 'http://localhost:9292'
    config.jwt_duration = 60*30 # 30 minutes
  end
end
