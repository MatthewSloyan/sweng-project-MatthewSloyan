Feature: login the user
 
  As an novice, intermediate or professional chef/hobbiest
  So that I can create an account to add and edit my own recipes
  I want to see the signup page and signup successfully 

Background: recipes and users have been added to database

  Given the following recipes exist:
  | recipe_name             | difficulty | servings | cook_time    | author       |
  | Parmesan spring chicken | Easy       | 4        | 20 Minutes   | Test_Author  |
  
  And the following users exist:
  | name         | username     | email           | password   | password_confirmation |
  | Matthew      | Test_Author  | test@gmail.com  | test1234   | test1234              |

  And I am on the RecipeFinder home page

  Scenario: sign up successfully with unique credentials
    # Follow signup link.
    When I follow "sign_up_link"

    # Check if on sign up page
    And I am on the sign up page

    # Fill in correct information
    And I fill in "name" with "Matthew"
    And I fill in "username" with "Test_User"
    And I fill in "email" with "test_user@gmail.com"
    And I fill in "password" with "test1234"
    And I fill in "password_confirmation" with "test1234"

    # Press log in.
    And I press "sign_up_button"

    # Route to home page if successful
    And I should see "An account for Test_User was successfully created. Please login."
    And I am on the RecipeFinder home page

Scenario: sign up unsuccessfully with non unique credentials
    # Follow signup link.
    When I follow "sign_up_link"
    And I am on the sign up page

    # Fill in correct information
    And I fill in "name" with "Matthew"
    And I fill in "username" with "Test_Author"
    And I fill in "email" with "test@gmail.com"
    And I fill in "password" with "test1234"
    And I fill in "password_confirmation" with "test1234"

    # Press log in.
    And I press "sign_up_button"

    # Route to home page if successful
    And I should see "An error occured, please read error messages below and try again."
    And I am on the sign up page

 