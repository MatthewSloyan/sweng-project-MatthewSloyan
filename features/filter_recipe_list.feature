Feature: display list of recipes filtered by difficulty rating
 
  As an novice, intermediate or professional chef
  So that I can quickly see recipes appropriate for my skill level
  I want to see recipes matching only certain difficulty ratings

Background: recipes have been added to database

  Given the following recipes exist:
  | recipe_name             | difficulty | servings | cook_time    | author     |
  | Parmesan spring chicken | Easy       | 4        | 20 Minutes   | Matthew_s  |
  | Slow roast chicken      | Medium     | 2        | 2.5 Hours    | Matthew_s  |
  | Oven-baked risotto      | Medium     | 4        | 30 Minutes   | Matthew_s  |
  | Pizza                   | Easy       | 4        | 30 Minutes   | Matthew_s  |
  | Pasta Bake              | Hard       | 6        | 50 Minutes   | Matthew_s  |
  | Chicken Curry           | Medium     | 2        | 30 Minutes   | Matthew_s  |
  | Lasagne                 | Hard       | 6        | 1.5 Hours    | Matthew_s  |

  And  I am on the RecipeFinder home page

Scenario: restrict to recipes with 'Easy' or 'Medium' difficulties
  # Check Easy & Medium, and uncheck Hard
  Given I check the following difficulties: Easy, Medium
  And I uncheck the following difficulties: Hard

  # Click refresh button
  And I press "refresh_page"

  # Ensure Easy and Medium difficulty recipes are visible
  Then I should see "Parmesan spring chicken" 
  And I should see "Slow roast chicken"
  And I should see "Oven-baked risotto" 
  And I should see "Pizza" 
  And I should see "Chicken Curry" 

  # Ensure Hard difficulty recipes are not visible
  Then I should not see "Lasagne"
  And I should not see "Pasta Bake"

Scenario: all difficulties selected
  # Ensure all recipes are displayed when all boxes selected.
  Given I check the following ratings: Easy, Medium, Hard
  Then I should see all the recipes