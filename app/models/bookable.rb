class Bookable < ActiveRecord::Base
  require 'icalendar'
  
  attr_accessible :name, :calendar_xml, :calendar_ical
  
  def events
    require 'open-uri'
    
    events = []
    
    ical = open(calendar_ical)
    
    Icalendar.parse(ical).first.freebusys.each do |item|
      event     = {
        :title  => item.dtstart.class == DateTime ? "#{item.dtstart.strftime('%l:%M%P')} - #{item.dtend.strftime('%l:%M%P')}" : "All day",
        :start  => item.dtstart,
        :end    => item.dtstart.class == DateTime ? item.dtend : item.dtstart,
        :allday => item.dtstart.class == DateTime ? false : true
      }
      
      events << event
    end
    
    return events
  end
  
end
