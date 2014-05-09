source 'https://rubygems.org'

#ruby=ruby-1.9.3
#ruby-gemset=office-calendar

gem 'rails', '~> 3.2.13'

gem 'sqlite3'
gem 'dotenv'
gem 'jquery-rails'
gem 'fullcalendar-rails', :git => 'git://github.com/theodi/fullcalendar-rails.git'
gem 'less-rails-bootstrap'
gem 'icalendar'
gem 'httparty'
gem 'nokogiri'
gem 'resque'
gem 'thin'
gem 'google-api-client'
gem 'redis-rails'
gem 'jbuilder'
gem 'friendly_id', '~> 4.0.9'

gem 'airbrake'

gem 'alternate_rails', :git => 'https://github.com/theodi/alternate-rails.git'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'foreman'
  gem 'mysql2'
end

group :test do
  gem 'poltergeist'
  gem 'pry'
  gem 'rspec-expectations'
  gem 'webmock'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner', '<= 1.0.1'
  gem 'vcr'
  gem 'coveralls'
end
