# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'bootsnap', require: false
gem 'puma'
gem 'rails', '< 6.0.0'
gem 'rake'
gem 'sprockets', '< 4.0.0'
gem 'sqlite3'
gem 'yard'

group :test do
  gem 'capybara'
  gem 'capybara-selenium'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :development do
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'cm_shared', path: File.expand_path('../../cm_shared', __dir__)
  gem 'pry-rails'
  # gem 'netzke-core'
  gem 'netzke-core', path: File.expand_path('../netzke-core', __dir__)
end
