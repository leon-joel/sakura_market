require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SakuraMarket
  class Application < Rails::Application
    
    # Set timezone
    config.time_zone = 'Tokyo'
    # config.active_record.default_timezone = :local

    # 日本語化
    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja

    # bootstrap対応で追記 Railstutorial 5.1.2
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

    # Viewの呼び出しをログ出力する?
    config.action_view.logger = nil

    # デフォルトのテンプレートエンジン
    config.generators.template_engine = :haml

    # assetsへのアクセスログを抑止するgem "quiet_assets" を使う?
    # config.quiet_assets = false

    # generatorの設定
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.view_specs false
      g.controller_specs false
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.assets false
      g.helper false
      g.jbuilder false
    end

    # # libファイルの自動読み込み
    # config.autoload_paths += %W(#{config.root}/lib)
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]
  
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
