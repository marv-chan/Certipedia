Feature: see link information
  
  As a prospective student
  So that I can find course information and search for more relevant information about the school
  I want to be able to view the certificate specifics

Background: courses in database

  Given the following certificates exist:
  | school                     |  name            | subject              |  website          |
  | Columbia University        |  Networking      | Computer Science     |  https://test.com |
  | New York University        |  Urban Planning  | Public Policy        |  https://test.com |
  | Columbia University        |  SQL             | Data Science         |  https://test.com |
  | Cornell University         |  Gogol           | Russian Literature   |  https://test.com |


Scenario: view certificate information
  Given I am on home page
  And I follow "More about SQL"
  Then I should see "Data Science"
  Then I should see "Columbia University"
  Then I should see "https://test.com"
  Then I should see "https://www.columbia.edu"
