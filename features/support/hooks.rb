Before("@resources") do
  VCR.use_cassette("Hooks") do
    @token = GCalResources.get_auth_token
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