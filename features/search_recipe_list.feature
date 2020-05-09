Feature: display list of recipes by searching using query
 
  As an novice, intermediate or professional chef
  So that I can quickly see recipes
  I want to see recipes matching only the search query

Background: recipes have been added to database

  Given the following recipes exist:
  | recipe_name             | difficulty | description     | servings | cook_time    |
  | Parmesan spring chicken | Easy       | chicken dish    | 4        | 20 Minutes   |
  | Slow roast chicken      | Medium     | chicken dish    | 2        | 120 Minutes  |
  | Oven-baked risotto      | Medium     | sample dish     | 4        | 30 Minutes   |
  | Pizza                   | Easy       | sample dish     | 4        | 30 Minutes   |
  | Pasta Bake              | Hard       | sample dish     | 6        | 50 Minutes   |
  | Chicken Curry           | Medium     | chicken dish    | 2        | 30 Minutes   |
  | Lasagne                 | Hard       | sample dish     | 6        | 90 Minutes   |

  And I am on the RecipeFinder home page

Scenario: search and find results with recipe name
  # Search for chicken, and click search.
  Given I search for: "chicken"
  And I press "search_recipes"

  # Ensure correct recipes are visible
  Then I should see "Chicken Curry" 
  And I should see "Parmesan spring chicken" 
  And I should see "Slow roast chicken"

Scenario: search and find results with description
  # Search for chicken curry, and click search.
  Given I search for: "sample"
  And I press "search_recipes"

  # Ensure correct recipes are visible.
  Then I should see "Oven-baked risotto" 
  And I should see "Pasta Bake" 
  And I should see "Lasagne"

Scenario: search and find no results
  # Search for Shepards Pie, and click search.
  Given I search for: "Shepards Pie"
  And I press "search_recipes"
  
  Then I should see all the recipes