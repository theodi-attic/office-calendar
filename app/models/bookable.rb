class Bookable < ActiveRecord::Base
  require 'icalendar'
  
  attr_accessible :name, :calendar_xml, :calendar_ical
  
  def events
    require 'open-uri'
    
    events = []
    
    ical = open(calendar_ical)
    
    Icalendar.parse(ical).first.freebusys.each do |item|
      event    = {
        :start => item.dtstart,
        :end   => item.dtend
      }
      
      events.push(event)
    end
    
    return events
  end
  
end
