require 'rails_helper'

# Tests below coded and adapted from lecture videos supplied.
describe RecipesController, type: 'controller' do

  # == CREATE == 
  describe "#create" do
    context "When a user adds a new recipe" do

      # Helper method to create a new movie, can be used in each test.
      let(:create_recipe) { 
          post :create, recipe: { recipe_name: 'Lasagne', description: 'Sample Description', difficulty: 'Medium', servings: 4, 
            cook_time: '20 Minutes', steps: ['Step 1.', 'Step 2.'], ingredients: ['Ingredient 1', 'Ingredient 2'], author: 'Test User'
          }
      }

      it "should create a new recipe" do
        # Expect post request created to change recipe count by one (add recipe)
        # Code adapted from: https://stackoverflow.com/questions/50630315/rspec-count-change-by
        expect { create_recipe }.to change { Recipe.count }.by(1)
      end

      it "should reload home page and display success message" do
        # Create post request.
        create_recipe

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for movie.
        # Code adated from: https://stackoverflow.com/questions/24919976/rspec-3-how-to-test-flash-messages
        expect(flash[:notice]).to eq("Lasagne was successfully created.")
      end
    end
  end
end