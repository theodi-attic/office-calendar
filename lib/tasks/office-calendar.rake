desc "Import and update resources"
task :importresources => :environment do
  require 'googlecalendar'
  
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