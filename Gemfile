source 'https://rubygems.org'

#ruby=ruby-1.9.3-p374
#ruby-gemset=office-calendar

gem 'rails', '3.2.13'

gem 'sqlite3'
gem 'dotenv'
gem 'jquery-rails'
gem 'fullcalendar-rails', :git => 'git://github.com/theodi/fullcalendar-rails.git'
gem 'less-rails-bootstrap', :git => 'git://github.com/theodi/less-rails-bootstrap.git'
gem 'icalendar'
gem 'httparty'
gem 'nokogiri'
gem 'resque'
gem 'resque-scheduler', :require => 'resque_scheduler'
gem 'thin'
gem 'google-api-client'
gem 'redis-rails'
gem 'jbuilder'
gem 'friendly_id', '~> 4.0.9'

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
  gem 'rspec-rails'
  gem 'webmock'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'vcr'
end