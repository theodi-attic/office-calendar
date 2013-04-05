thin:       bundle exec thin start
worker:     bundle exec rake resque:work TERM_CHILD=1 QUEUES=office_calendar
scheduler:  bundle exec rake resque:scheduler 