source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'pg'
gem 'devise'
gem 'jquery-rails'
gem 'slim'
gem 'nokogiri', '~> 1.5.9'

# Omniauth gems
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'

# Image managing
gem 'rmagick', '2.13.2'
gem 'carrierwave'

# feed
gem 'feedzirra'

#cron
gem 'whenever', :require => false

#search
gem 'sunspot_rails'
gem 'sunspot_solr'

#ActiveAdmin
gem 'activeadmin'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'therubyracer', :platforms => :ruby
  gem "less-rails"
	gem "twitter-bootstrap-rails", :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'cucumber-rails', '~> 1.3.1', :require => false
  gem "rspec-rails"
  gem 'factory_girl_rails'
  gem "email_spec"
  gem "pickle"
  gem 'database_cleaner'
  gem "sunspot_test"
  gem "selenium-webdriver"
end

group :development do
  gem "rspec-rails"
  gem "thin"
  gem "capistrano"
  gem "capistrano-ext"
  gem "dark-capistrano-recipes"
end

group :production do
  gem 'unicorn'
end
