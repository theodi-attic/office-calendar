class GCalResources
  require 'rubygems'
  require 'httparty'
  require 'nokogiri'
  require 'google/api_client'
  
  include HTTParty

  def self.get_resources
    token = get_auth_token
  
    doc = Nokogiri::XML self.get("https://apps-apis.google.com/a/feeds/calendar/resource/2.0/#{ENV['GAPPS_DOMAIN_NAME']}/", :headers => { "Authorization" => "GoogleLogin auth=#{token}", "Content-type" => "application/atom+xml"}).response.body

    resources = []

    doc.search('entry').each do |i|
      resources << {
        :id          => i.search('.//apps:property[@name="resourceId"]').attr('value').text,
        :name        => i.search('.//apps:property[@name="resourceCommonName"]').attr('value').text,
        :email       => i.search('.//apps:property[@name="resourceEmail"]').attr('value').text,
        :description => i.search('.//apps:property[@name="resourceDescription"]').attr('value').text,
        :type        => i.search('.//apps:property[@name="resourceType"]').attr('value').text
      }
    end
    
    return resources
  end
  
  def self.get_events(email)
    token = get_oauth_token
    
    events = []
    json = JSON.parse HTTParty.get("https://www.googleapis.com/calendar/v3/calendars/#{email}/events?timeZone=Europe%2FLondon", :headers => { "Authorization" => "OAuth #{token}"}).response.body
    
    unless json["items"].nil?
      json["items"].each do |item|
        unless item['start'].nil? 
          events << {
            :id      => item['id'],
            :title   => item['end']['dateTime'].nil? ? "All Day" : "#{parse_time(item['start'].flatten[1])} - #{parse_time(item['end'].flatten[1])}",
            :start   => DateTime.parse(item['start'].flatten[1]),
            :end     => item['end']['dateTime'].nil? ? DateTime.parse(item['end'].flatten[1]) - 1.minute : DateTime.parse(item['end'].flatten[1]),
            :allday  => item['end']['dateTime'].nil? ? true : false,    
            :created => DateTime.parse(item['created']),
            :updated => DateTime.parse(item['updated']) 
          }
        end
      end
    end
    
    return events
  end
  
  def self.get_oauth_token
      path = Rails.root.join("#{ENV['GAPPS_PUBLIC_KEY_FINGERPRINT']}-privatekey.p12")
    
      key = Google::APIClient::PKCS12.load_key(path, 'notasecret')      
      asserter = Google::APIClient::JWTAsserter.new(ENV['GAPPS_SERVICE_ACCOUNT_EMAIL'],
          'https://www.googleapis.com/auth/calendar http://www.google.com/calendar/feeds/', key)
      client = Google::APIClient.new
      client.authorization = asserter.authorize(ENV['GAPPS_USER_EMAIL'])
      client.authorization.access_token
  end
  
  def self.get_auth_token
    post = {
      'accountType' => 'HOSTED_OR_GOOGLE',
      'Email' => ENV['GAPPS_USER_EMAIL'],
      'Passwd' => ENV['GAPPS_PASSWORD'],
      'service' => 'apps',
      'source' => 'odi-officecalendar-0.1'
    }
  
    response = self.post('https://www.google.com/accounts/ClientLogin', :body => post)
      
    if response.header.code.to_i == 200
      response.body.lines.each do |line|
        if line.chomp.index('Auth=')
          return line.chomp.gsub('Auth=', '')
        end
      end
    end
  end
  
  def self.parse_time(datetime)
    DateTime.parse(datetime).strftime('%l:%M%P').strip
  end

end