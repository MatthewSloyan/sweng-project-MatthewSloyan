Feature: login the user
 
  As an novice, intermediate or professional chef/hobbiest
  So that I can login to my account to add and edit my own recipes
  I want to see the login page and login successfully 

Background: recipes and users have been added to database

  Given the following recipes exist:
  | recipe_name             | difficulty | servings | cook_time    | author       |
  | Parmesan spring chicken | Easy       | 4        | 20 Minutes   | Test_Author  |
  
  And the following users exist:
  | name         | username     | email           | password   | password_confirmation |
  | Matthew      | Test_Author  | test@gmail.com  | test1234   | test1234              |

  And I am on the RecipeFinder home page

  Scenario: fill in my email and password correctly
    # Follow login link.
    When I follow "log_in_link"

    # Check if on login page
    And I am on the log in page

    # Fill in correct email and password.
    And I fill in "email_username" with "test@gmail.com"
    And I fill in "password" with "test1234"

    # Press log in.
    And I press "log_in_button"

    # Route to home page if successful
    And I am on the RecipeFinder home page

 Scenario: fill in my username and password correctly
    # Follow login link.
    When I follow "log_in_link"

    # Check if on login page
    And I am on the log in page

    # Fill in correct email and password.
    And I fill in "email_username" with "Test_Author"
    And I fill in "password" with "test1234"

    # Press log in.
    And I press "log_in_button"

    # Route to home page if successful
    And I am on the RecipeFinder home page

Scenario: fill in my username or email but password incorrectly
    # Follow login link.
    When I follow "log_in_link"

    # Check if on login page
    And I am on the log in page

    # Fill in correct email and password.
    And I fill in "email_username" with "test@gmail.com"
    And I fill in "password" with "fail_password"

    # Press log in.
    And I press "log_in_button"

    # Reload login page if incorrect.
    And I am on the log in page

Scenario: fill in my username or email and password incorrectly
    # Follow login link.
    When I follow "log_in_link"

    # Check if on login page
    And I am on the log in page

    # Fill in correct email and password.
    And I fill in "email_username" with "fail_user"
    And I fill in "password" with "fail_password"

    # Press log in.
    And I press "log_in_button"

    # Reload login page if incorrect.
    And I am on the log in page