# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.2.2"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 3.11"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# A set of Rails responders to dry up your application
gem "responders"
# Draper adds an object-oriented layer of presentation logic to your Rails apps.
gem "draper", "~> 3.1"
# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"
# Role based authorization gem
gem "access-granted"
# fcm provides ruby bindings to Firebase Cloud Messaging (FCM) a cross-platform messaging solution that lets you reliably deliver messages and notifications at no cost to Android, iOS or Web browsers.
gem "fcm", "~> 0.0.6"
# Flexible authentication solution for Rails with Warden
gem "devise"
gem "devise_token_auth"
# ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.
gem "active_model_serializers"
# Allows marking ActiveRecord objects as discarded, and provides scopes for filtering.
gem "discard", "~> 1.0"
# For frontend stylesheets
gem "bootstrap"
gem "font-awesome-sass"
gem "execjs"
gem "jquery-rails", "~> 4.3", ">= 4.3.3"
# Full calendar
gem "fullcalendar-rails"
gem "momentjs-rails"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Kaminari is a Scope & Engine based, clean, powerful, agnostic, customizable and sophisticated paginator for Rails 4+
gem "kaminari"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# A custom Rails FormBuilder that assumes HTML5. Because HTML4 is for chumps.
gem "simple_form"
# jQuery UI for the Rails asset pipeline
gem "jquery-ui-rails"
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"
# Magic gem
gem "listen", ">= 3.0.5", "< 3.2"
gem "faker"
# Roo can access the contents of various spreadsheet files. It can handle * OpenOffice * Excelx * LibreOffice * CSV
gem "roo", "~> 2.8", ">= 2.8.2"
# Geokit provides geocoding and distance calculation in an easy-to-use API
gem "geokit", "~> 1.13", ">= 1.13.1"
gem 'rack-cors', :require => 'rack/cors'

gem "annotate"
gem "rubocop-rails_config"
# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem "chromedriver-helper"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
