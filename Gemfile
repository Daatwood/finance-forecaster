# frozen_string_literal: true

source 'https://rubygems.org'
ruby '~> 2.4.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.19'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Bootstrap for CSS
gem 'autoprefixer-rails'
gem 'bootstrap-sass', '~> 3.3.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
# Authentication
gem 'devise'
# gem 'griddler'
gem 'postmark-rails'
# Edit in place
gem 'best_in_place'
# Bootstrap 3 Colorpicker
gem 'jquery-minicolors-rails'
# Use haml as the templating engine
gem 'haml-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Kickass javascript charts
gem 'chartkick'
# Handle err routes
gem 'exception_handler'
# Sitemap Generator
gem 'sitemap_generator'
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
group :development, :test do
  gem 'byebug'
  gem 'spring'
end

gem 'bootstrap-addons-rails', group: :assets

# Open email instantly in browser
group :development do
  gem 'better_errors'
  gem 'html2haml'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rubocop'
  gem 'web-console', '~> 2.0'
end

# Heroku Pinger
# gem 'newrelic_rpm'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
group :development, :test do
  gem 'dotenv-rails'
  gem 'railroady'
  gem 'unicorn'
  gem 'unicorn-rails'
end

group :production do
  gem 'passenger'
  gem 'rails_12factor'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
