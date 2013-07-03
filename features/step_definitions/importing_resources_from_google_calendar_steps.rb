require 'pry'

Given(/^there is a new resource with the following fields in Google Apps:$/) do |table|  
  table.hashes.each do |row|
    row.each_pair do |key, value|    
      instance_variable_set("@resource_#{key}", value)
    end
  end
  
  xml = "<?xml version='1.0' encoding='utf-8'?>
<atom:entry xmlns:atom='http://www.w3.org/2005/Atom' xmlns:apps='http://schemas.google.com/apps/2006'>
  <apps:property name='resourceId' value='#{@resource_id}'/>
  <apps:property name='resourceCommonName' value='#{@resource_name}'/>
  <apps:property name='resourceDescription' value='#{@resource_description}'/>
  <apps:property name='resourceType' value='#{@resource_type}'/>
</atom:entry>"
  HTTParty.post("https://apps-apis.google.com/a/feeds/calendar/resource/2.0/#{ENV['GAPPS_DOMAIN_NAME']}/", :body => xml,  :headers => { 'Authorization' => "GoogleLogin auth=#{@token}", 'Content-Type' => 'application/atom+xml' })  
end

When(/^the import task has run$/) do
  ImportResources.perform
end

Given(/^there is already a resource with the id "(.*?)" and the name "(.*?)" in Google Apps$/) do |id, name|
  @resource_name = name
  @id = id
  doc = Nokogiri::XML HTTParty.get("https://apps-apis.google.com/a/feeds/calendar/resource/2.0/#{ENV['GAPPS_DOMAIN_NAME']}/#{@id}", 
        :headers => { 'Authorization' => "GoogleLogin auth=#{@token}", 'Content-Type' => 'application/atom+xml' }).response.body
  doc.inner_text.should include(id)
end

When(/^I visit the homepage$/) do
  visit('/')
end

Then(/^I should see a resource called "(.*?)"$/) do |name|
  page.should have_content name
end

Then(/^when I click on that item$/) do
  page.first(:link, @resource_name).click
end

Then(/^I should see it has a description "(.*?)"$/) do |description|
  page.should have_content description
end

Given(/^that resource's description has been changed$/) do
  @new_description = "Where evil things are not done - honest!"
  xml = "<atom:entry xmlns:atom='http://www.w3.org/2005/Atom'>
    <apps:property xmlns:apps='http://schemas.google.com/apps/2006' name='resourceDescription' value='#{@new_description}'/>
</atom:entry>"
  response = HTTParty.put("https://apps-apis.google.com/a/feeds/calendar/resource/2.0/#{ENV['GAPPS_DOMAIN_NAME']}/#{@id}",
                :body => xml, :headers => { 'Authorization' => "GoogleLogin auth=#{@token}", 'Content-Type' => 'application/atom+xml' })
end

Then(/^I should see the changed description$/) do
  visit('/')
  page.should have_content @resource_name
  page.first(:link, @resource_name).click
end

Given(/^there is no longer a resource with the id "(.*?)" and the name "(.*?)" in Google Apps$/) do |id, name|
  @resource_name = name
  HTTParty.delete("https://apps-apis.google.com/a/feeds/calendar/resource/2.0/#{ENV['GAPPS_DOMAIN_NAME']}/#{id}", 
                  :headers => { 'Authorization' => "GoogleLogin auth=#{@token}", 
                                'Content-Type'  => "application/atom+xml" 
                                })  
end

Then(/^I should not see a resource called "(.*?)"$/) do |arg1|
  visit('/')
  page.should_not have_content @resource_name
end