require 'google_calendar'

class ImportResources
  @queue = :office_calendar
  
  def self.perform
    
    GCal::Resources.get_resources.each do |res|
      resource = Resource.find_or_create_by_google_id(res[:id])
      resource.update_attributes(
        :name         => res[:name], 
        :email        => res[:email], 
        :description  => res[:description], 
        :resourcetype => res[:type],
        :active       => true
      )
      resource.touch  
    end
    
    if Resource.all.size > 0    
      last_updated = DateTime.parse(Resource.order("updated_at desc").limit(1).first.updated_at.to_s)
    
      Resource.where("updated_at < ?", last_updated).each do |resource|
        resource.update_attributes(
          :active => false
        )
      end
    end
  end
end