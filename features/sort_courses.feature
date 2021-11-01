Feature: sort courses by features

  As a prospective student
  So that I can find courses based on sort parameters
  I want to be able to sort courses

Background: courses in database

  Given the following courses exist:
  | University      |  Title           | Department           | Application Deadline   |
  | Columbia        |  Networking      | Computer Science     |  2021-12-15            |
  | NYU             |  Urban Planning  | Public Policy        |  2022-1-5              |
  | Columbia        |  SQL             | Data Science         |  2021-12-15            |
  | Cornell         |  Gogol           | Russian Literature   |  2021-12-10            |


Scenario: sort by university
  Given I am on home page
  And I follow "University"
  Then I should see "Gogol" before "Urban Planning"
  Then I should see "Networking" before "Gogol"


Scenario: sort by title
  Given I am on home page
  And I follow "Title"
  Then I should see "Gogol" before "Networking"
  Then I should see "Networking" before "SQL"
