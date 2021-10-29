Feature: add courses to database

  as a website user(or admin?)
  so that I can find courses by university
  I want to be able to add courses to the database

Scenario: navigate to add course page
  Given I am on home page
  When I follow "Add Course"
  Then I should see "Add Course"


Scenario: add course to database
  Given I am on new page
  And I fill in "University" with "Columbia"
  And I fill in "Department" with "Computer Science"
  And I fill in "Application Deadline" with "January 15, 2022"
  And I press "Add Course"
  Then I should be on the home page
  And I should see "Columbia"
