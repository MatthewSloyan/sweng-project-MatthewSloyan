require 'rails_helper'

# Tests below coded and adapted from lecture videos supplied.
describe RecipesController, type: 'controller' do

  # == SETUP ==
  # Helper method to create a new recipe, can be used in multiple tests.
  let(:create_recipe) { 
      post :create, recipe: { recipe_name: 'Lasagne', description: 'Sample Description', difficulty: 'Medium', servings: 4, 
        cook_time: '20 Minutes', steps: ['Step 1.', 'Step 2.'], ingredients: ['Ingredient 1', 'Ingredient 2'], author: 'Test User'
    }
  }

  # == CREATE == 
  describe "#create" do
    context "When a user adds a new recipe" do

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

        # Expect to display flash message for recipe.
        # Code adated from: https://stackoverflow.com/questions/24919976/rspec-3-how-to-test-flash-messages
        expect(flash[:notice]).to eq("Lasagne was successfully created.")
      end
    end
  end

  # == UPDATE == 
  describe "#update" do
    context "When a user updates a recipe" do

      it "should edit a given recipe" do
        # Create post request (Helper method).
        create_recipe

        # Setup fake data to check if updated.
        @fake_results = double('Recipe', recipe_name: 'Test', description: 'Sample description', difficulty: 'Medium', servings: 2, 
          cook_time: '20 Minutes', steps: ['Step 1.', 'Step 2.'], ingredients: ['Ingredient 1', 'Ingredient 2'], author: 'Test User')

        # Expect update request created to change recipe count by one as recipe is created and updated.
        expect { 
            put :update, id: "1", recipe: {recipe_name: "Test", servings: 2 } 
        }.to change { Recipe.count }.by(0)

        # Check if updated recipe equals to fake data.
        expect(Recipe.find("1").recipe_name).to eq(@fake_results.recipe_name)
      end

      it "should display success message" do
        # Create post request (Helper method).
        create_recipe

        # Call update method and updated created recipe.
        put :update, id: "1", recipe: {recipe_name: "Test", servings: 2 } 

        # Expect to load recipe page.
        expect(@respose).to redirect_to(@result)

        # Expect to display flash message for recipe.
        expect(flash[:notice]).to eq("Test was successfully updated.")
      end
    end
  end

  # == EDIT == 
  describe "#edit" do
    context "When a user loads the edit page" do
      it "should find recipe to edit" do
          # Setup fake results
          @fake_results = double('Recipe', recipe_name: 'Lasagne', description: 'Sample Description', difficulty: 'Medium', servings: 4, 
            cook_time: '20 Minutes', steps: ['Step 1.', 'Step 2.'], ingredients: ['Ingredient 1', 'Ingredient 2'], author: 'Test User')

          # Have to add stub for :find or else it would throw error that id not found in recipes controller.
          allow(Recipe).to receive(:find).and_return(@fake_results)

          # call recipes controller and pass in param
          get :edit, {id: "1"}
          expect(Recipe.find("1")).to eq(@fake_results)
      end
    end
  end

  # == DESTROY/DELETE == 
  describe "#delete" do
    context "When a user deletes a recipe" do

      it "should destroy a given recipe" do
        # Create post request (Helper method).
        create_recipe

        # Expect delete request created to change recipe count by -1
        expect { delete :destroy, :id => '1' }.to change { Recipe.count }.by(-1)
      end

      it "should return to home page and display success message" do
        # Create post request (Helper method).
        create_recipe

        # Delete new recipe created above, by calling destroy method.
        delete :destroy, :id => '1'

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for recipe.
        expect(flash[:notice]).to eq("Lasagne was successfully deleted.")
      end
    end
  end

  # == SHOW == 
  describe "#show" do
    context "When a user selects a recipe" do
      it "should show the recipe information" do
        # Setup fake results, can be used in multiple tests.
        @fake_results = double('Recipe', recipe_name: 'Lasagne', description: 'Sample Description', difficulty: 'Medium', servings: 4, 
          cook_time: '20 Minutes', steps: ['Step 1.', 'Step 2.'], ingredients: ['Ingredient 1', 'Ingredient 2'], author: 'Test User')

        # Have to add stub for :find or else it would throw error that id not found in recipes_controller.
        allow(Recipe).to receive(:find).and_return(@fake_results)

        # Call show method, and expect found recipe to equal @fake_results and for template to render.
        get :show, {:id => "1"}
        expect(Recipe.find("1")).to eq(@fake_results)
        expect(@respose).to render_template('recipes/show')
      end
    end
  end

  # == INDEX == 
  describe "#index" do
    context "When a user loads the home page" do
      it "should render index template" do
          # Call controller index check if template is rendered.
          get :index, {}
          expect(@respose).to render_template("index")
      end
    end
  end

  # == SIMILAR AUTHORS/USERS ==
  describe "#similar_authors" do
    context "When a user selects an author/user" do
      # == SETUP == 
      # Helper method used for the below tests, I abstracted this out as it was common to both.
      let(:setup_results) { 
        # Setup fake results.
        @fake_results = double('Recipe', recipe_name: 'Test', description: 'Sample description', difficulty: 'Medium', servings: 2, 
          cook_time: '20 Minutes', steps: ['Step 1.', 'Step 2.'], ingredients: ['Ingredient 1', 'Ingredient 2'], author: 'Test_user')
        
        # Create stub for :find_by_author
        # Had to add stub for :find or else it would throw error that id not found in recipes_controller.
        allow(Recipe).to receive(:find).and_return(@fake_results)
        allow(Recipe).to receive(:find_by_author).with('Test_user').and_return(@fake_results)
      }

      # == TESTS == 
      it "should find recipes by that author" do
        # Call setup method
        setup_results
        
        # Ensure find_directors is called, and returns results if recipes contains director.
        expect(Movie).to receive(:find_by_author)

        # call recipe controller
        get :search_authors, {:id => '1'}
      end
      it "should select the search similar recipes template for rendering" do
        # Call setup method
        setup_results
        
        # call recipes controller
        get :search_authors, {:id => '1'}

        # Expect to load search_directors template.
        expect(@respose).to render_template('search_authors')

        # As suggested in feedback for CA5, check that the correct data is supplied to the view
        #expect(@respose).to eq(..)
      end
    end
  end
end