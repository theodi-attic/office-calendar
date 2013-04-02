require 'pry'

Given(/^that a booking has been made in Google Calendar for between (#{DATETIME}) and (#{DATETIME})$/) do |from, to|
   @resource = Resource.find_by_google_id(@resource_id)
   @from = from
   @to = to
   @event = GCal::Events.create_event("Planning some evil", from, to, @resource.email)
end

Given(/^I visit the page for that resource$/) do
  visit('/')
  page.click_link(@resource_name)
end

Given(/^I navigate to the correct month$/) do
  page.execute_script("$('#calendar').fullCalendar('gotoDate', #{@from.strftime("%Y")}, #{@from.strftime("%m").to_i - 1}, 1)")
end

Then(/^I should see a booking for that time$/) do
  page.has_css?(".#{@from.strftime("Date%Y%m%d%H%M%S")}").should === true
end

Then(/^it should not be an all day event$/) do
  page.find(".#{@from.strftime("Date%Y%m%d%H%M%S")}").should_not have_content "All Day"
end

Then(/^it should be an all day event$/) do
  page.find(".#{@from.strftime("Date%Y%m%d%H%M%S")}").should have_content "All Day"
end

Given(/^that a booking has been made in Google Calendar for all day on (#{DATE})$/) do |date|
  @resource = Resource.find_by_google_id(@resource_id)
  @from = date
  @to = date
  @event = GCal::Events.create_event("Planning yet more evil", date, date, @resource.email)
end

Given(/^the resource has been removed from the booking$/) do
  GCal::Events.update_event(@resource.email, @event['id'])
end

Then(/^I should not see a booking for that time$/) do
  page.has_css?(".#{@from.strftime("Date%Y%m%d%H%M%S")}").should === false
end