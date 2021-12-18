Feature: display list of certificates filtered by school

  As a prospective student
  So that I can find courses from the universities I'm interested in
  I want to see certificates matching only certain universities

Background: courses in database

  Given the following certificates exist:
  | school                     |  name            | subject              |  website          |
  | Columbia University        |  Networking      | Computer Science     |  https://test.com |
  | New York University        |  Urban Planning  | Public Policy        |  https://test.com |
  | Columbia University        |  SQL             | Data Science         |  https://test.com |
  | Cornell University         |  Gogol           | Russian Literature   |  https://test.com |

Scenario: restrict to certificates with "New York University" and "Cornell University"
  # enter step(s) to check the 'PG' and 'R' checkboxes
  # enter step(s) to uncheck all other checkboxes
  # enter step to "submit" the search form on the homepage
  # enter step(s) to ensure that PG and R movies are visible
  # enter step(s) to ensure that other movies are not visible
  Given I am on home page
  #When I check the following schools: New York University, Cornell University
  When I select "New York University" from "schools"
  When I select "Cornell University" from "schools"
  When I unselect "Columbia University" from "schools"
  When I press "Refresh"
  Then I should see "Urban Planning"
  Then I should see "Gogol"
  Then I should not see "SQL"
  Then I should not see "Networking"
