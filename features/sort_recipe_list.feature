Feature: display list of recipes sorted by different criteria
 
  As an novice, intermediate or professional chef
  So that I can quickly see recipes based on my preferences
  I want to see recipes sorted by name or cooking time

Background: recipes have been added to database

  Given the following recipes exist:
  | recipe_name             | difficulty | servings | cook_time    |
  | Parmesan spring chicken | Easy       | 4        | 40 Minutes   |
  | Slow roast chicken      | Medium     | 2        | 120 Minutes  |
  | Oven-baked risotto      | Medium     | 4        | 30 Minutes   |
  | Pizza                   | Easy       | 4        | 25 Minutes   |
  | Pasta Bake              | Hard       | 6        | 50 Minutes   |
  | Chicken Curry           | Medium     | 2        | 30 Minutes   |
  | Lasagne                 | Hard       | 6        | 100 Minutes  |

  And  I am on the RecipeFinder home page

Scenario: sort recipes alphabetically
  When I follow "recipe_name_header"
  
  Then I should see "Pasta Bake" before "Pizza"
  And I should see "Pasta Bake" before "Slow roast chicken"
  And I should see "Chicken Curry" before "Lasagne"
  And I should see "Oven-baked risotto" before "Parmesan spring chicken"

Scenario: sort movies in decreasing order of cooking time
  When I follow "cook_time_header"

  Then I should see "Pizza" before "Pasta Bake"
  And I should see "Pasta Bake" before "Slow roast chicken"
  And I should see "Chicken Curry" before "Lasagne"
  And I should see "Oven-baked risotto" before "Parmesan spring chicken"