class GCalResources
  require 'rubygems'
  require 'httparty'
  require 'nokogiri'
  require 'google/api_client'

  def self.get_resources
    token = get_auth_token
  
    doc = Nokogiri::XML HTTParty.get("https://apps-apis.google.com/a/feeds/calendar/resource/2.0/theodi.org/", :headers => { "Authorization" => "GoogleLogin auth=#{token}", "Content-type" => "application/atom+xml"}).response.body

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
      'Email' => ENV['GAPPS_EMAIL'],
      'Passwd' => ENV['GAPPS_PASSWORD'],
      'service' => 'apps',
      'source' => 'odi-officecalendar-0.1'
    }
  
    response = HTTParty.post('https://www.google.com/accounts/ClientLogin', :body => post)
  
    if response.header.code.to_i == 200
      response.body.lines.each do |line|
        if line.chomp.index('Auth=')
          return line.chomp.gsub('Auth=', '')
        end
      end
    end
  end
end

class ImportResources
  @queue = :office_calendar
  
  def self.perform
    
    GCalResources.get_resources.each do |res|
      resource = Resource.find_or_create_by_google_id(res[:id])
      resource.update_attributes(
        :name         => res[:name], 
        :email        => res[:email], 
        :description  => res[:description], 
        :resourcetype => res[:type]
      )
      puts resource.inspect
    end  
       
  end
end