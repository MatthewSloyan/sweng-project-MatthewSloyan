Feature: display list of recipes by the same user
 
  As an novice, intermediate or professional chef
  So that I can quickly see recipes by my favourite user/author
  I want to see recipes only created by this author

Background: recipes have been added to database

  Given the following recipes exist:
  | recipe_name             | difficulty | servings | cook_time    | author       |
  | Parmesan spring chicken | Easy       | 4        | 20 Minutes   | Matthew_s    |
  | Slow roast chicken      | Medium     | 2        | 120 Minutes  | Test_author  |
  | Oven-baked risotto      | Medium     | 4        | 30 Minutes   | Matthew_s    |
  | Pizza                   | Easy       | 4        | 30 Minutes   | Matthew_s    |
  | Pasta Bake              | Hard       | 6        | 50 Minutes   | Test_author  |
  | Chicken Curry           | Medium     | 2        | 30 Minutes   | Test_author  |
  | Lasagne                 | Hard       | 6        | 90 Minutes   | Matthew_s    |

  And  I am on the RecipeFinder home page

Scenario: find recipes with same author
  Given I am on the RecipeFinder home page
  When  I follow "Test_author"
  Then  I should be on the Authors page for "Test_author"
  And   I should see "Slow roast chicken"
  And   I should see "Pasta Bake"
  And   I should see "Chicken Curry"
  But   I should not see "Parmesan spring chicken"
  And   I should not see "Oven-baked risotto"
  And   I should not see "Pizza"