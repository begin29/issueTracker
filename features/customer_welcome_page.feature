Feature: Customer welcome page
  As an customer
  I want to create ticket and receive email with ticket link

  Scenario: View welcome page
    Given I am viewing "welcome page"
    Then I should be on the page with the "title" message "Welcome to issue tracking system!"
    And I should see a button with a value of "Create Ticket Request"

  Scenario: Create ticket request
    Given I am viewing "welcome page"
    When I click "Create Ticket Request"
    Then I should be on the page with the "title" message "New Ticket"
    And I fill in "email" with "test@email.com"
    And I fill in "first name" with "Petro"
    And I fill in "last name" with "Ivanenko"
    And I fill in "subject" with "Test subject"
    And I fill in "description" with "Some long description"
    And I press "Create"
    Then I should be on the page with the "alert success" message "New ticket request was created."
    And customer with email "test@email.com" should receive message with subject 'Your request on site "http://myawesomesite.com" was created!' and ticket link with format "[a-z]{3}-[\d]{3}-[a-z]{3}-[\d]{3}-[a-z]{3}"