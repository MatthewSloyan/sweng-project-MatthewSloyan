
# Background for features to create seed data for users and recipes.
Given /the following recipes exist/ do |recipes_table|
  recipes_table.hashes.each do |recipe|
    Recipe.create recipe
  end
end

And /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  before = page.body.index(e1)
  after = page.body.index(e2)

  # Check for recipes sorted alphabetically or by cooking time.
  expect(before < after)
end

# Check or uncheck difficulty boxes.
When /I (un)?check the following difficulties: (.*)/ do |uncheck, difficulty_list|
  difficulty_list.split(', ').each do |difficulty|
    step %{I #{uncheck.nil? ? '' : 'un'}check "difficulty_#{difficulty}"}
  end
end

# Make sure that all the recipes in the app are visible in the table
Then /I should see all the recipes/ do
  Recipe.all.each do |recipe|
    step %{I should see "#{recipe.recipe_name}"}
  end
end

# Fill in search bar with string.
Given("I search for: {string}") do |string|
  step %{I fill in "search" with "#{string}"}
end