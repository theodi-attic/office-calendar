class GCalResources
  require 'rubygems'
  require 'httparty'
  require 'nokogiri'

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