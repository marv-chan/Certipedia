Feature: bookmark certificate 

  As a user
  So that I can look up courses that I want easily
  I want to be able to keep track of interesting courses I find

Background: courses in database

  Given the following certificates exist:
  | school                     |  name            | subject              |  website          |
  | Columbia University        |  Networking      | Computer Science     |  https://test.com |
  | New York University        |  Urban Planning  | Public Policy        |  https://test.com |
  | Columbia University        |  SQL             | Data Science         |  https://test.com |
  | Columbia University        |  Gogol           | Computer Science     |  https://test.com |

Scenario: create bookmark with login 
  Given I am on new user page
  And I fill in "name" with "test"
  And I fill in "Username" with "test"
  And I fill in "Password" with "123123"
  And I press "Sign Up"
  When I follow "More about Gogol"
  And I follow "Create Bookmark"
  
