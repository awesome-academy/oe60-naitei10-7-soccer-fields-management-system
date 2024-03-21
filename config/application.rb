# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oe60Naitei107SoccerFieldsManagementSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))
    config.hosts << "d739-14-165-110-148.ngrok-free.app"
    config.hosts << "d739-14-165-110-148.ngrok-free.app"
    config.hosts << "localhost:3000"
    config.i18n.available_locales = %I[en vi]
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.default_locale = :vi
    config.generators do |g|
      g.template_engine :erb, turbo_stream: true
    end
  end
end
