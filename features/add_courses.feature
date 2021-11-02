Feature: add courses to database

  as a website user(or admin?)
  so that I can find courses by university
  I want to be able to add courses to the database

Scenario: navigate to add course page
  Given I am on home page
  When I follow "Add new certificate"
  Then I should see "Create New Certification"


Scenario: add course to database
  Given I am on new page
  And I select "Columbia University" from "School"
  And I fill in "Name" with "C++"
  And I fill in "Program" with "Computer Science"
  And I fill in "Website" with "http://nothing.com"
  And I press "Save Changes"
  Then I should be on home page
  And I should see "C++"
  And I should see "Computer Science"
  And I should see "C++ was successfully created"


Scenario: add course to without website should work
  Given I am on new page
  And I select "New York University" from "School"
  And I fill in "Name" with "Dostoevsky"
  And I fill in "Program" with "Russian"
  And I press "Save Changes"
  Then I should be on home page
  And I should see "Dostoevsky"
  And I should see "Russian"
