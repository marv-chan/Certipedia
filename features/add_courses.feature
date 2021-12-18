Feature: add courses to database

  as an admin
  so that I can find courses by university
  I want to be able to add courses to the database

Background: logged in as Admin
  Given I am on new user page
  And I fill in "name" with "admin"
  And I fill in "Username" with "admin"
  And I fill in "Password" with "admin"
  When I press "Sign Up"
  And I fill in "Username" with "admin"
  And I fill in "Password" with "admin"
  When I press "Login"

Scenario: navigate to add course page as admin


  Given I am on home page
  When I follow "Add Certificate"
  Then I should see "Create New Certification"


Scenario: add course to database after logging in as admin

  Given I am on home page
  When I follow "Add Certificate"
  And I select "Columbia University" from "School"
  And I fill in "Name" with "C++"
  And I fill in "Subject" with "Computer Science"
  And I fill in "Website" with "http://nothing.com"
  And I press "Save Changes"
  Then I should be on home page
  And I should see "C++"
  And I should see "Computer Science"
  And I should see "C++ was successfully created"
