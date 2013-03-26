module ResourceHelper
  
  def ical(calendar, resource)
    resource.events.each do |event|
      e               = Icalendar::Event.new
      e.uid           = event[:id]   
      e.dtstart       = event[:start]    
      e.dtend         = event[:end] 
      e.summary       = "Room booking for #{event[:title]}" 
      e.location      = resource.name  
      e.created       = event[:created]
      e.last_modified = event[:updated]
      calendar.add e
    end
    calendar.publish
    calendar.to_ical
  end
  
end
