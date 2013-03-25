class Resource < ActiveRecord::Base
  
  attr_accessible :name, :email, :description, :type, :resourcetype, :active
  
  def calendar_xml
    "http://www.google.com/calendar/feeds/#{URI::escape(email)}/private/basic"
  end
  
  def calendar_ical
    "http://www.google.com/calendar/ical/#{URI::escape(email)}/private/basic.ics"
  end
  
  def events
    Rails.cache.fetch("gcal_events/#{email}", :expires_in => 1.hour) do
      GCalResources.get_events(email)
    end
  end
  
end