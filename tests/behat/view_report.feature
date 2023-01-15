@mod @mod_questionnaire
Feature: Questionnaire reports can be accessed
  In order to view a questionnaire report
  As a teacher
  I need to be able to see the report.

  @javascript
  Scenario: Add a questionnaire and then fill it and then view thereport
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | student1 | Student   | 1        | student1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |
    And the following "activities" exist:
      | activity      | name               | description                    | course | idnumber       |
      | questionnaire | Test questionnaire | Test questionnaire description | C1     | questionnaire0 |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I follow "Test questionnaire"
    And I navigate to "Questions" in current page administration
    And I add a "Yes/No" question and I fill the form with:
      | Question Name | Q1 |
      | Yes | y |
      | Question Text | Are you still in School? |
    Then I should see "[Yes/No] (Q1)"
    And I navigate to "Feedback" in current page administration
    And I set the field "Feedback options" to "Feedback sections"
    And I press "Save settings"
    And I log out
    And I log in as "student1"
    And I am on "Course 1" course homepage
    And I follow "Test questionnaire"
    And I navigate to "Answer the questions..." in current page administration
    And I click on "Yes" "radio"
    And I press "Submit questionnaire"
    Then I should see "Thank you for completing this Questionnaire."
    And I press "Continue"
    And I log out
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I follow "Test questionnaire"
    Then I should see "View all responses"
    And I navigate to "Feedback" in current page administration
