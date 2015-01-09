Feature: Customer welcome page
  As an customer
  I want to create ticket and receive email with ticket link

  Scenario: View welcome page
    Given I am viewing "welcome page"
    Then I should see "Welcome to issue tracking system"
    And I should see a button with a value of "Create Ticket Request"

  Scenario: Create ticket request
    Given I am viewing "welcome page"
    When I press "Create Ticket Request"
    Then I should see "New Ticket"
    And I fill in "email" with "test@email.com"
    And I fill in "title" with "test subject"
    And I fill in "description" with "test description"
    And I press "Create"
    Then I should see "New request was created."
    And customer should receive an email with ticket link