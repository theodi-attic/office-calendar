Before("@resources") do
  VCR.use_cassette("Hooks") do
    @token = GCalResources.get_auth_token
  end
end

After("@calendar") do
  VCR.use_cassette("Hooks") do
    # Delete created events
    GCalResources.get_resources.each do |resource|
      GCalResources.get_events(resource[:email]).each do |event|
        token = GCalResources.get_oauth_token
        HTTParty.delete("https://www.googleapis.com/calendar/v3/calendars/#{resource[:email]}/events/#{event[:id]}", 
                        :headers => { 'Authorization' => "OAuth #{token}" }).response.body  
      end
    end
  end
end

at_exit do
  VCR.use_cassette("Hooks") do
    @token = GCalResources.get_auth_token
    # Delete all the things!
    GCalResources.get_resources.each do |resource|
      # DELETE https://apps-apis.google.com/a/feeds/calendar/resource/2.0/{domain name}/{resourceId}
      HTTParty.delete("https://apps-apis.google.com/a/feeds/calendar/resource/2.0/#{ENV['GAPPS_DOMAIN_NAME']}/#{resource[:id]}", 
                      :headers => { 'Authorization' => "GoogleLogin auth=#{@token}", 
                                    'Content-Type'  => "application/atom+xml" 
                                    })  
    end    
  end
end