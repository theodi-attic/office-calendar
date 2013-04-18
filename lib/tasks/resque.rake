require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = 'office_calendar'
end