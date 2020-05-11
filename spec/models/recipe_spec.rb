require 'rails_helper'

describe "#ratings" do
  it "should return all difficulties" do
    # Check for word array of difficulties
    expect(Recipe.all_difficulties).to eq(["Easy", "Medium", "Hard"])
  end
end

describe "#similar" do
  it "should find movies by the same director" do
    # Setup three recipes, two with the same author.
    Movie.create(recipe_name: 'Pizza', description: 'Sample description', author: 'Test_user')
    Movie.create(recipe_name: 'Lasagne', description: 'Sample description', author: 'Test_user')
    Movie.create(recipe_name: 'Pasta', description: 'Sample description', author: 'User_1234')
    
    # Get recipes with the same author.
    results = Movie.find_by_author('Test_user')
    
    # Check if results only contains recipes by 'Test_user'
    expect(results[0].recipe_name).to eq('Pizza')
    expect(results[1].recipe_name).to eq('Lasagne')
  end

  it "should not find movies by different directors" do

    # Setup three recipes, two with the same author.
    Movie.create(recipe_name: 'Pizza', description: 'Sample description', author: 'Test_user')
    Movie.create(recipe_name: 'Lasagne', description: 'Sample description', author: 'Test_user')
    pasta = Movie.create(recipe_name: 'Pasta', description: 'Sample description', author: 'User_1234')
    
    # Get recipes with the same author.
    results = Movie.find_by_author('Test_user')

    # Check if results doesn't contain Pasta recipe.
    # Code adapted from: https://ruby-doc.org/core-2.7.1/Module.html#method-i-include
    expect(results).not_to include(pasta)
  end
end
