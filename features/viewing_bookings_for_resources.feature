@vcr @resources @javascript @calendar
Feature: View bookings for resources

  Background:
    Given there is a new resource with the following fields in Google Apps:
    | id     | name             | type         | description                |
    | 123456 | Fortress of evil | Meeting Room | Where evil things are done |
    And the import task has run
    
    Scenario: Viewing a booking for a specific time
      Given that a booking has been made in Google Calendar for between 2020-01-04 10:00 and 2020-01-04 15:00
      And I visit the page for that resource
      And I navigate to the correct month
      Then I should see a booking for that time
      And it should not be an all day event
    
    Scenario: Viewing an all day booking
      Given that a booking has been made in Google Calendar for all day on 2020-01-07
      And I visit the page for that resource
      And I navigate to the correct month
      Then I should see a booking for that time
      And it should be an all day event
    
    Scenario: Canceled bookings should not show
      Given that a booking has been made in Google Calendar for between 2020-01-05 14:00 and 2020-01-05 16:00
      And the resource has been removed from the booking
      And I visit the page for that resource
      Then I should not see a booking for that time