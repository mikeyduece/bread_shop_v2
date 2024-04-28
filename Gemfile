# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

gem 'dry_serialization'
gem 'jsonapi-serializer'

gem 'mongoid', '~> 7.0.5'

gem 'rails', '~> 6.1.3.1'

# gem 'pg', '>= 0.18', '< 2.0'
gem 'faker'
gem 'multi_json', '~> 1.11', '>= 1.11.2'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'versionist'
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

gem 'jbuilder', '~> 2.5'
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'auth0_current_user'
gem 'cancancan', '~> 2.0'
gem 'dalli'
gem 'database_cleaner'
gem 'jquery-rails'
gem 'newrelic_rpm'
gem 'stream_rails'

gem 'figaro'
gem 'rubocop', require: false
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false

gem 'sorbet', :group => :development
gem 'sorbet-runtime'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'tapioca', '> 0.11.2', require: false
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'launchy'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop-rspec'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
