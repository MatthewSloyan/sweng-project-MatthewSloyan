Feature: display list of recipes by the same user
 
  As an novice, intermediate or professional chef/hobbiest
  So that I can quickly see recipes by my favourite user/author
  I want to see recipes only created by this author

Background: recipes have been added to database

  Given the following recipes exist:
  | recipe_name             | difficulty | servings | cook_time    | author       |
  | Parmesan spring chicken | Easy       | 4        | 20 Minutes   | Test_Author  |
  
  And the following users exist:
  | name         | username     | email           | password   | password_confirmation |
  | Matthew      | Test_Author  | test@gmail.com  | test1234   | test1234              |

  And  I am on the RecipeFinder home page

Scenario: find recipes with same author
  Given I am on the RecipeFinder home page
  # Could only have one recipe in test as I couldn't get the xpath working to select the correct link in table.
  When  I follow "view_user"
  Then  I should be on the Authors page for "Test_Author"
  And   I should see "Parmesan spring chicken"
  And   I should not see "Oven-baked risotto"