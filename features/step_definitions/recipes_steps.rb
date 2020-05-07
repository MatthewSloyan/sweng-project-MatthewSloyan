
# Background for features to create seed data.
Given /the following recipes exist/ do |recipes_table|
  recipes_table.hashes.each do |recipe|
    Recipe.create recipe
  end
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