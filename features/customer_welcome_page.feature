Feature: Customer welcome page
  As an customer
  I want to create ticket and receive email with ticket link
  And view my ticket with history

  Scenario: View welcome page
    Given I am viewing "welcome page"
    Then I should be on the page with the "title" message "Welcome to issue tracking system!"
    And I should see a button with a value of "Create Ticket Request"

  Scenario: Create ticket request
    Given I am viewing "welcome page"
    When I click "Create Ticket Request"
    Then I should be on the page with the "title" message "New Ticket"
    And I fill in "input" named "email" with "test@email.com"
    And I fill in "input" named "first name" with "Petro"
    And I fill in "input" named "last name" with "Ivanenko"
    And I fill in "input" named "subject" with "Test subject"
    And I fill in "textarea" named "description" with "Some long description"
    And I press "Create"
    Then I should be on the page with the "alert success" message "New ticket request was created."
    And customer with email "test@email.com" should receive message with subject 'Your request on site "http://myawesomesite.com" was created!' and ticket link with format "[a-z]{3}-[\d]{3}-[a-z]{3}-[\d]{3}-[a-z]{3}"

  Scenario: View ticket
    Given exist customer "test@email.com" with requested email
    Then I follow to ticket show page by link with format "[a-z]{3}-[\d]{3}-[a-z]{3}-[\d]{3}-[a-z]{3}" from email
    Then I should be on the page with the "title" message "Show Ticket"
    And I fill in "textarea" named "description" with "new update from user"
    And I press "Update"
    Then I should be on the page with the "alert success" message "Ticket was updated."