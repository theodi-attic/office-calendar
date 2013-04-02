class Resource < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  attr_accessible :name, :email, :description, :type, :resourcetype, :active
  
  def events
    Rails.cache.fetch("gcal_events/#{email}", :expires_in => 1.hour) do
      GCal::Events.get_events(email)
    end
  end
  
end