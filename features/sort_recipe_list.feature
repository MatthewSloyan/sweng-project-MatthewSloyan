Feature: display list of recipes sorted by different criteria
 
  As an novice, intermediate or professional chef
  So that I can quickly see recipes based on my preferences
  I want to see recipes sorted by name or cooking time

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

Scenario: sort recipes alphabetically
  # Click on recipe name header, and check order of rows.
  When I follow "recipe_name_header"
  
  Then I should see "Pasta Bake" before "Pizza"
  And I should see "Pasta Bake" before "Slow roast chicken"
  And I should see "Chicken Curry" before "Lasagne"
  And I should see "Oven-baked risotto" before "Parmesan spring chicken"

Scenario: sort movies in decreasing order of cooking time
  # Click on cooking time header, and check order of rows.
  When I follow "cook_time_header"

  Then I should see "Pizza" before "Pasta Bake"
  And I should see "Pasta Bake" before "Slow roast chicken"
  And I should see "Chicken Curry" before "Lasagne"
  And I should see "Oven-baked risotto" before "Parmesan spring chicken"