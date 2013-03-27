@vcr @resources
Feature: Import resources from the Google Apps API to the Rails app

  Scenario: Import new resources
    Given there is a new resource with the following fields in Google Apps:
    | id     | name             | type         | description                |
    | 123456 | Fortress of evil | Meeting Room | Where evil things are done |
    When the import task has run
    And I visit the homepage
    Then I should see a resource called "Fortress of evil"
    And when I click on that item
    Then I should see it has a description "Where evil things are done"
    
  Scenario: Update resources
    Given there is already a resource with the id "123456" and the name "Fortress of evil" in Google Apps
    And that resource's description has been changed
    When the import task has run
    And I visit the homepage
    Then I should see a resource called "Fortress of evil"
    And when I click on that item
    Then I should see the changed description
    
  Scenario: Old resources are no longer visible
    Given there is no longer a resource with the id "123456" and the name "Fortress of evil" in Google Apps
    When the import task has run
    And I visit the homepage
    Then I should not see a resource called "Fortress of evil"
