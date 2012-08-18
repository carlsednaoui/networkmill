source 'http://rubygems.org'

gem 'rails', '3.2.8'
gem 'json'
gem 'jquery-rails'
gem 'devise'
gem 'haml'
gem 'rmagick'
gem 'carrierwave'
gem 'delayed_job_active_record'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier',     '>= 1.0.3'
  gem 'roots-rails'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem "capybara-webkit"
  gem 'factory_girl_rails'
  gem 'launchy' #used to run $save_and_open_page with capybara
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'thin'
end
