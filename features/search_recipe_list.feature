Feature: display list of recipes by searching using query
 
  As an novice, intermediate or professional chef
  So that I can quickly see recipes
  I want to see recipes matching only the search query

Background: recipes have been added to database

  Given the following recipes exist:
  | recipe_name             | difficulty | description     | servings | cook_time    | author     |
  | Parmesan spring chicken | Easy       | chicken dish    | 4        | 20 Minutes   | Matthew_s  |
  | Slow roast chicken      | Medium     | chicken dish    | 2        | 2.5 Hours    | Matthew_s  |
  | Oven-baked risotto      | Medium     | sample dish     | 4        | 30 Minutes   | Matthew_s  |
  | Pizza                   | Easy       | sample dish     | 4        | 30 Minutes   | Matthew_s  |
  | Pasta Bake              | Hard       | sample dish     | 6        | 50 Minutes   | Matthew_s  |
  | Chicken Curry           | Medium     | chicken dish    | 2        | 30 Minutes   | Matthew_s  |
  | Lasagne                 | Hard       | sample dish     | 6        | 1.5 Hours    | Matthew_s  |

  And I am on the RecipeFinder home page

Scenario: search and find results
  # Search for chicken curry, and click search.
  Given I search for: "Chicken Curry"
  And I press "search_recipes"

  # Ensure correct recipes are visible
  Then I should see "Chicken Curry" 
  And I should see "Parmesan spring chicken" 
  And I should see "Slow roast chicken"

Scenario: search and find no results
  # Search for Shepards Pie, and click search.
  Given I search for: "Shepards Pie"
  And I press "search_recipes"
  
  Then I should see all the recipes