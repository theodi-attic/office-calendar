class Resource < ActiveRecord::Base
  
  attr_accessible :name, :email, :description, :type, :resourcetype
  
  def calendar_xml
    "http://www.google.com/calendar/feeds/#{URI::escape(email)}/public/basic"
  end
  
  def calendar_ical
    "http://www.google.com/calendar/ical/#{URI::escape(email)}/public/basic.ics"
  end
  
  def events    
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