class Resource < ActiveRecord::Base
  
  attr_accessible :name, :email, :description, :type, :resourcetype, :active
  
  def events
    Rails.cache.fetch("gcal_events/#{email}", :expires_in => 1.hour) do
      GCalResources.get_events(email)
    end
  end
  
end