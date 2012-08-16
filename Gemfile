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
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'launchy' #use $save_and_open_page to see where rspec is at
end

group :production do
  gem 'pg'
  gem 'thin'
end
