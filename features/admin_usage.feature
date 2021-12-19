Feature: admin usage

  as a website admin
  I want to be able to edit certificate
  so that I can manage the content shown on the website
  
Background: courses in database

  Given the following certificates exist:
  | school                     |  name            | subject              |  website          |
  | Columbia University        |  Networking      | Computer Science     |  https://test.com |
  | New York University        |  Urban Planning  | Public Policy        |  https://test.com |
  | Columbia University        |  SQL             | Data Science         |  https://test.com |
  | Cornell University         |  Gogol           | Russian Literature   |  https://test.com |
  
Scenario: log in as admin
  Given I am on home page
  When I follow "Sign Up"
  And I fill in "name" with "admin"
  And I fill in "Username" with "admin"
  And I fill in "Password" with "admin"
  Then I press "Sign Up"
  And I should see "Login"
  And I follow "Login"
  And I fill in "Username" with "admin"
  And I fill in "Password" with "admin"
  And I press "Login"
  And I should see "Add Certificate"
  Then I follow "Add Certificate"
  Then I should see "Create New Certification"
  When I go to home page
  Then I follow "More about Networking"
  Then I should see "Delete Certificate"
  When I follow "Delete Certificate"
  When I go to home page
  Then I should not see "More about Networking"
  When I follow "Logout"
  Then I should see "You have logged out"