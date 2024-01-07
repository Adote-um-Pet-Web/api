# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'jbuilder', '~> 2.11', '>= 2.11.5'
gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'pg', '~> 1.5', '>= 1.5.4'
gem 'puma', '~> 6.4'
gem 'rack-cors'
gem 'rails', '~> 7.0.8'

# Auth
gem 'devise_token_auth', '~> 1.2', '>= 1.2.2'
gem 'pundit', '~> 2.3', '>= 2.3.1'
gem 'rolify', '~> 6.0', '>= 6.0.1'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.2'
  gem 'ffaker', '~> 2.23'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 6.1'
  gem 'shoulda-matchers', '~> 5.3'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
