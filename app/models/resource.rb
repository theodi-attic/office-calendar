class Resource < ActiveRecord::Base
  
  attr_accessible :name, :email, :description, :type, :resourcetype
  
  def calendar_xml
    "http://www.google.com/calendar/feeds/#{URI::escape(email)}/private/basic"
  end
  
  def calendar_ical
    "http://www.google.com/calendar/ical/#{URI::escape(email)}/private/basic.ics"
  end
  
  def events    
    token = GCalResources.get_oauth_token
    
    events = []
    json = JSON.parse HTTParty.get("https://www.googleapis.com/calendar/v3/calendars/#{email}/events?timeZone=Europe%2FLondon", :headers => { "Authorization" => "OAuth #{token}"}).response.body
    
    json["items"].each do |item|
      unless item['start'].nil?
        puts item
        events << {
          :title  => item['end']['dateTime'].nil? ? "All Day" : "#{parse_time(item['start'].flatten[1])} - #{parse_time(item['end'].flatten[1])}",
          :start  => DateTime.parse(item['start'].flatten[1]),
          :end    => item['end']['dateTime'].nil? ? DateTime.parse(item['end'].flatten[1]) - 1.minute : DateTime.parse(item['end'].flatten[1]),
          :allday => item['end']['dateTime'].nil? ? true : false       
        }
      end
    end
    
    return events
  end
  
  def parse_time(datetime)
    DateTime.parse(datetime).strftime('%l:%M%P').strip
  end

  
end