Feature: user sign up

  as a website user
  I want to be able to sign up
  so that I can use the website

Scenario: navigate to sign up page
  Given I am on home page
  When I follow "Login"
  Then I should see "Sign Up"

Scenario: create new user
  Given I am on new user page
  And I fill in "name" with "test"
  And I fill in "Username" with "test"
  And I fill in "Password" with "123123"
  When I press "Sign Up"
  And I should see "User was created"

Scenario: cancel in the middle of signing up
  Given I am on new user page
  And I fill in "name" with "test"
  And I fill in "Username" with "test"
  And I fill in "Password" with "123123"
  When I follow "Cancel"
  And I should not see "User was created"

Scenario:
  Given I am on new user page
  And I fill in "name" with "test"
  And I fill in "Username" with "test"
  And I fill in "Password" with "123123"
  When I follow "Cancel"
  And I should not see "User was created"

Scenario: User is able to login after creating account
  Given I am on new user page
  And I fill in "name" with "test"
  And I fill in "Username" with "test"
  And I fill in "Password" with "123123"
  When I press "Sign Up"
  And I should see "Log in"
  And I fill in "Username" with "test"
  And I fill in "Password" with "123123"
  When I press "Login"
  And I should see "Here are courses you have bookmarked"
