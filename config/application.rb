require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
Bundler.require(*Rails.groups)

module TweetPicker
  class Application < Rails::Application
    config.load_defaults 5.2

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.environment_value = config_for(:environment_value)

    config.generators do |g|
      g.test_framework  false
      g.helper          false
      g.stylesheets     false
      g.javascripts     false
    end
  end
end
