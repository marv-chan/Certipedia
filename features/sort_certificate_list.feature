Feature: display list of certificates sorted by different criteria 
 
  As an avid student
  So that I can quickly browse certificates based on my preferences
  I want to see certificates sorted by name or subject

Background: courses in database

  Given the following certificates exist:
  | school                     |  name            | subject              |  website          |
  | Columbia University        |  Networking      | Computer Science     |  https://test.com |
  | New York University        |  Urban Planning  | Public Policy        |  https://test.com |
  | Columbia University        |  SQL             | Data Science         |  https://test.com |
  | Cornell University         |  Gogol           | Russian Literature   |  https://test.com |

Scenario: sorted by name 
  # enter step(s) to check the 'PG' and 'R' checkboxes
  # enter step(s) to uncheck all other checkboxes
  # enter step to "submit" the search form on the homepage
  # enter step(s) to ensure that PG and R movies are visible
  # enter step(s) to ensure that other movies are not visible
  Given I am on home page
  When I follow "Certificate Name"
  Then I should see "Gogol" before "Networking"
  Then I should see "Networking" before "SQL"
  Then I should see "SQL" before "Urban Planning"
  
Scenario: sorted by subject 
  # enter step(s) to check the 'PG' and 'R' checkboxes
  # enter step(s) to uncheck all other checkboxes
  # enter step to "submit" the search form on the homepage
  # enter step(s) to ensure that PG and R movies are visible
  # enter step(s) to ensure that other movies are not visible
  Given I am on home page
  When I follow "Subject Area"
  Then I should see "Computer Science" before "Data Science"
  Then I should see "Data Science" before "Public Policy"
  Then I should see "Public Policy" before "Russian Literature"

Scenario: sorted by subject 
  # enter step(s) to check the 'PG' and 'R' checkboxes
  # enter step(s) to uncheck all other checkboxes
  # enter step to "submit" the search form on the homepage
  # enter step(s) to ensure that PG and R movies are visible
  # enter step(s) to ensure that other movies are not visible
  Given I am on home page
  When I follow "School"
  Then I should see "Networking" before "Gogol"
  Then I should see "SQL" before "Urban Planning"
  

