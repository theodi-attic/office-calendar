if ENV['AIRBRAKE_CALENDAR_KEY']
  Airbrake.configure do |config|
    config.api_key = ENV['AIRBRAKE_CALENDAR_KEY']
  end
end
