Feature: view certificate information

  As a prospective student
  So that I can find course information
  I want to be able to view the certificate specifics

Background: courses in database

  Given the following certificates exist:
  | school                     |  name            | subject              |  website          |
  | Columbia University        |  Networking      | Computer Science     |  https://test.com |
  | New York University        |  Urban Planning  | Public Policy        |  https://test.com |
  | Columbia University        |  SQL             | Data Science         |  https://test.com |
  | Columbia University        |  Gogol           | Computer Science     |  https://test.com |



Scenario: view certificate information
  Given I am on home page
  When I follow "More about Gogol"
  Then I should see "Computer Science"
  Then I should see "Columbia University"
