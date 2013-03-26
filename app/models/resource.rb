class Resource < ActiveRecord::Base
  
  attr_accessible :name, :email, :description, :type, :resourcetype, :active
  
  def events
    Rails.cache.fetch("gcal_events/#{email}", :expires_in => 1.hour) do
      GCalResources.get_events(email)
    end
  end
  
  def ical
    event = self.events
    es = []
    events.each do |event|
      e               = Icalendar::Event.new
      e.uid           = event[:id]   
      e.dtstart       = event[:start]    
      e.dtend         = event[:end] 
      e.summary       = "Room booking for #{event[:title]}" 
      e.location      = self.name  
      e.created       = event[:created]
      e.last_modified = event[:updated]
      es << e
    end
    es
  end
  
end