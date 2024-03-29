require_relative "boot"

require "rails"
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
# require 'active_job/railtie'
require 'action_cable/engine' # Bug that requires this: https://github.com/hotwired/turbo-rails/issues/512
# require 'action_mailbox/engine'
require 'action_text/engine'
require 'rails/test_unit/railtie'
# require 'rack_cors'

Bundler.require(*Rails.groups)

module ProjectLogger
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "localhost:*", "127.0.0.1:*"
        resource "*",
                 headers: :any,
                 methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_storage.variant_processor = :mini_magick
  end
end
