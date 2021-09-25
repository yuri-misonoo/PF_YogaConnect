require_relative 'boot'

require 'rails/all'

require 'obscenity/active_model'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yoga
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    #タイムゾーンを日本時間に設定
    config.time_zone = 'Asia/Tokyo'
    config.active_record.default_timezone = :utc

    #デフォルトのロケールを日本（ja）に設定
    config.i18n.default_locale = :ja

    #週の始まりを日曜にする
    config.beginning_of_week = :sunday

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

  end
end
