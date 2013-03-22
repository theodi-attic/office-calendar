require 'resque'
require 'resque_scheduler'
require 'googlecalendar'

Resque.redis = ENV['RESQUE_REDIS_HOST']
Resque.schedule = YAML.load_file(Rails.root.join('config', 'schedule.yml'))