# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 7.0.8'

gem 'active_model_serializers'
gem 'activerecord-postgresql-adapter'
gem 'annotate'
gem 'bleib', '0.0.8' # For deployment
gem 'bootsnap'
gem 'carrierwave'
gem 'config'
gem 'countries'
gem 'cssbundling-rails'
gem 'database_cleaner'
gem 'devise'
gem 'faker'
gem 'haml-rails'
gem 'i18n_data'
gem 'jsbundling-rails'
gem 'language_list'
gem 'mini_magick'
gem 'net-imap', require: false
gem 'net-ldap', '~> 0.16.0'
gem 'net-pop', require: false
gem 'net-smtp', require: false
gem 'nokogiri', '~> 1.16'
gem 'odf-report'
gem 'omniauth-keycloak'
gem 'omniauth-rails_csrf_protection'
gem 'pg'
gem 'pg_search'
gem 'psych', '~> 3.3', '>= 3.3.4'
gem 'puma'
gem 'rack'
gem 'rails-i18n'
gem 'rest-client'
gem 'seed-fu'
gem 'sentry-raven'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

group :metrics do
  gem 'brakeman'
  gem 'haml_lint', require: false
  gem 'rubocop'
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code
  # to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'i18n-tasks', '~> 1.0.14'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'bullet'
  gem 'dotenv'
  gem 'listen'
  gem 'rb-readline'
  # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem 'rails-erd'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano', '3.18.0'
  gem 'capistrano-rvm', '0.1.2'
  gem 'capistrano-rails', '1.4.0'
  gem 'capistrano-passenger'
  gem 'capistrano-bundler', '1.5.0'
  gem 'capistrano3-puma', '~> 5.2'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver', '>= 4.11.8'
  gem 'simplecov'
  # Use fixed version of webdrivers to avoid compatibility issues with chrome and chromedriver
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'rails-controller-testing', '~> 1.0'
gem 'bootstrap', '~> 5.0.0'
gem 'config'
gem 'puma_worker_killer'
gem 'passenger'
gem 'base64', '~> 0.2.0'
gem 'ed25519', '~> 1.2'
gem 'bcrypt_pbkdf', '~> 1.0'
