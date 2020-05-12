require "rails_helper"

describe "#ratings" do
  it "should return all difficulties" do
    # Check for word array of difficulties
    expect(Recipe.all_difficulties).to eq(["Easy", "Medium", "Hard"])
  end
end

describe "#find_by_author" do
  it "should not find recipes by the same author" do

    # Setup three recipes, two with the same author.
    Recipe.create(recipe_name: "Pizza", description: "Sample description", author: "Test_user")
    Recipe.create(recipe_name: "Lasagne", description: "Sample description", author: "Test_user")
    pasta = Recipe.create(recipe_name: "Pasta", description: "Sample description", author: "User_1234")
    
    # Get recipes with the same author.
    results = Recipe.find_by_author("Test_user")

    # Check if results doesn"t contain Pasta recipe.
    # Code adapted from: https://ruby-doc.org/core-2.7.1/Module.html#method-i-include
    expect(results).not_to include(pasta)
  end
end
