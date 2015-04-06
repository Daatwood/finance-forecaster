source 'https://rubygems.org'
ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Bootstrap for CSS
gem 'bootstrap-sass', '~> 3.3.0'
gem 'autoprefixer-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
# Authentication
gem 'devise'
gem 'devise_invitable', '~> 1.3.4'
gem 'griddler'
gem 'postmark-rails'
gem 'griddler-postmark'
# Edit in place
gem "best_in_place"
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
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

gem 'bootstrap-addons-rails', group: :assets

# Open email instantly in browser
group :development do
  gem 'better_errors'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'letter_opener'
end

# Send pushover notifications
#gem 'rushover'
#gem 'netrc', git: 'https://github.com/geemus/netrc.git'
#gem 'pushover'
# Required for pushover
#gem 'sys-proctable', git: 'https://github.com/djberg96/sys-proctable.git'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
group :development, :test do
  gem 'unicorn'
  gem 'unicorn-rails'
end

group :production do
  gem "passenger"
  gem 'rails_12factor'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
