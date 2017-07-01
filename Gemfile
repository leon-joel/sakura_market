source 'https://rubygems.org'
ruby '2.3.3'


git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Bootstrap & Bootswatch & font-awesome
gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'font-awesome-rails'

# http://www.mk-mode.com/octopress/2015/01/08/rails-installation-bootstrap-bootswatch/
gem 'autoprefixer-rails'

# turbolinks support
# gem 'jquery-turbolinks'

# sprocket-rails (3.0.0 is not good...)
# gem 'sprockets-rails', '2.3.3'

# See https://raw.githubusercontent.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# CSS Support
# gem 'less-rails'

# App Server
# gem 'unicorn'

# Slim
# gem 'slim-rails'

# Haml
gem 'hamlit-rails'
# gem 'haml-rails'
group :development do
  # gem 'erb2haml'
  gem 'erb2haml-leon', '>= 0.1.5.7', github: 'leon-joel/erb2haml-leon'
  # gem 'erb2haml-leon', path: '../erb2haml-leon'
end

# Assets log cleaner
# gem 'quiet_assets'

# Form Builders
gem 'simple_form'

# # Process Management
# gem 'foreman'

# PG/MySQL Log Formatter
# gem 'rails-flog'

# Pagenation
gem 'kaminari'
# gem 'kaminari', '~> 0.17' # kaminari1.0からmongodbサポートがなくなるそうなので、0.x に固定しておく。
# gem 'kaminari-mongoid'  # kaminari1.0にした場合には kaminari-mongoid が必要になるとのこと。
# group :development, :test do
#   gem 'mongoid-rspec', github: "chocoken517/mongoid-rspec"
# end

# NewRelic
# gem 'newrelic_rpm'

# Hash extensions
# gem 'hashie'

# Cron Manage
# gem 'whenever', require: false

# Presenter Layer Helper
# gem 'active_decorator'

# Table(Migration) Comment
# gem 'migration_comments'

# Exception Notifier
# gem 'exception_notification'

group :development do
  # gem 'html2slim'

  # N+1問題の検出
  # gem 'bullet'

  # Rack Profiler
  # gem 'rack-mini-profiler'

  # for Debug
  gem 'ruby-debug-ide'
  gem 'debase'

  # Error時の表示を分かりやすく
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  # Pry & extensions
  # gem 'pry-rails'
  # gem 'pry-coolline'
  # gem 'pry-byebug'
  # gem 'rb-readline'

  # PryでのSQLの結果を綺麗に表示
  # gem 'hirb'
  # gem 'hirb-unicode'

  # pryの色付けをしてくれる
  # gem 'awesome_print'

  # Rspec
  gem 'rspec-rails'
  gem 'rails-controller-testing'  # for assigns method ※https://github.com/rails/rails-controller-testing

  # test fixture
  gem 'factory_girl_rails'

  # Deploy
  # gem 'capistrano', '~> 3.2.1'
  # gem 'capistrano-rails'
  # gem 'capistrano-rbenv'
  # gem 'capistrano-bundler'
  # gem 'capistrano3-unicorn'
end

group :test do
  # HTTP requests用のモックアップを作ってくれる
  # gem 'webmock'
  # gem 'vcr'

  # Time Mock
  gem 'timecop'

  # テスト用データを生成
  # gem 'faker'

  # テスト環境のテーブルをきれいにする
  # gem 'database_rewinder'
  gem 'database_cleaner'  # テスト実行後にDBをクリア

  gem 'capybara'          # for feature spec
  gem 'launchy'           # Capybaraでテスト中に現在のページをブラウザで開ける

  gem 'poltergeist'       # headless driver
end

group :production, :staging do
  # ログ保存先変更、静的アセット Heroku 向けに調整
  # gem 'rails_12factor'  # Rails5から不要になったとのこと
end
