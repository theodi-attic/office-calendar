require 'resque'
require 'resque_scheduler'
require 'import_resources'

Resque.redis = Redis.new(
  :host => ENV['RESQUE_REDIS_HOST'], 
  :port =>  ENV['RESQUE_REDIS_PORT'],
  :password => (ENV['RESQUE_REDIS_PASSWORD'].nil? || ENV['RESQUE_REDIS_PASSWORD']=='' ? nil : ENV['RESQUE_REDIS_PASSWORD'])
)

Resque.schedule = YAML.load_file(Rails.root.join('config', 'schedule.yml'))