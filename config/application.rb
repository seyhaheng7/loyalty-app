require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodingateProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths += Dir["#{config.root}/lib/"]
    config.autoload_paths += Dir["#{config.root}/lib/**"]

    config.generators do |g|
      g.test_framework  :rspec
      g.assets  false
      g.helper false
      g.stylesheets false
    end
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.enabled = true
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.precompile += %w( .svg .eot .woff .ttf)
    config.active_record.default_timezone = :local
    config.time_zone = 'Bangkok'

    if ENV['ENABLE_S3'] == 'true'
      if ENV['ASSETS_HOST'].present?
        config.action_controller.asset_host = ENV['ASSETS_HOST']
      else
        config.action_controller.asset_host = "//#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com"
      end

      config.assets.prefix = "/assets"
    else
      config.action_controller.asset_host = ENV['ASSETS_HOST']
    end

    config.after_initialize do
      Bullet.enable = true
      Bullet.alert = false
      Bullet.bullet_logger = true
      Bullet.console = false
      Bullet.growl = false
      Bullet.rails_logger = false
    end
    config.action_cable.allowed_request_origins = [/http:\/\/*/, /https:\/\/*/, /file:\/\/*/]
  end
end

