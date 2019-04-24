# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

gem 'administrate'

gem 'aws-sdk-polly', '~> 1.6.0'
gem 'aws-sdk-s3', '~> 1.17.0'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise', '~> 4.4.3'
gem 'devise-async', '~> 1.0.0'
gem 'jbuilder', '~> 2.5'
gem 'letter_opener', '~> 1.7.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq', '~> 5.1.3'
gem 'sidekiq-cron', '~> 1.1'

gem 'aasm', '~> 5.0.2'

gem 'honeybadger', '~> 4.0'
gem 'timber', '~> 2.6'

gem 'graphql'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.5'

group :development, :test do
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'pronto'
  gem 'pronto-rubocop', require: false
  gem 'pry'
end

group :development do
  gem 'annotate'
  gem 'foreman'
  gem 'graphiql-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails_real_favicon'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'chromedriver-helper'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'rspec-rails', '~> 3.7'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'simplecov'
end
