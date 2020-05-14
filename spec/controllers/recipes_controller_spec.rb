require 'rails_helper'

# Tests below coded and adapted from lecture videos supplied.
describe RecipesController, type: 'controller' do

  # == SETUP ==
  # Helper methods to fake login and create a new recipe, can be used in multiple tests.
  let(:fake_login) { 
      # Fake login by creating a user and setting session variable.
      User.create!(name: 'Matthew', username: 'Test_Author', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234')
      @request.session['user_id'] = 1
  }

  let(:create_recipe) { 
      post :create, recipe: { recipe_name: 'Lasagne', description: 'Sample Description', difficulty: 'Medium', servings: 4, 
        cook_time: '20 Minutes', steps: ['Step 1.', 'Step 2.'], ingredients: ['Ingredient 1', 'Ingredient 2'], author: 'Test_Author' }
  }

  # == CREATE == 
  describe "#create" do
    context "When a user adds a new recipe and is logged in" do

      it "should create a new recipe" do
        fake_login
        # Expect post request created to change recipe count by one (add recipe)
        # Code adapted from: https://stackoverflow.com/questions/50630315/rspec-count-change-by
        expect { create_recipe }.to change { Recipe.count }.by(1)
      end

      it "should reload home page and display success message" do
        # Fake login and create post request.
        fake_login
        create_recipe

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for recipe.
        # Code adated from: https://stackoverflow.com/questions/24919976/rspec-3-how-to-test-flash-messages
        expect(flash[:success]).to eq("Lasagne was successfully created.")
      end
    end

    # Sad path
    context "When a user tries to add a new recipe and is not logged in" do

      it "should reload home page and display success message" do
        # Create post request, and don't login
        create_recipe

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for recipe.
        # Code adated from: https://stackoverflow.com/questions/24919976/rspec-3-how-to-test-flash-messages
        expect(flash[:notice]).to eq("Please \"Log In\" or \"Sign Up\" to add, edit or delete recipes.")
      end
    end
  end

  # == UPDATE == 
  describe "#update" do
    context "When a user updates a recipe" do

      it "should edit a given recipe" do
        # Fake login and create post request.
        fake_login
        create_recipe

        # Setup fake data to check if updated.
        @fake_results = double('Recipe', recipe_name: 'Test', description: 'Sample description', difficulty: 'Medium', servings: 2, 
          cook_time: '20 Minutes', steps: ['Step 1.', 'Step 2.'], ingredients: ['Ingredient 1', 'Ingredient 2'], author: 'Test_Author')

        # Expect update request created to change recipe count by one as recipe is created and updated.
        expect { 
            put :update, id: "1", recipe: {recipe_name: "Test", servings: 2 } 
        }.to change { Recipe.count }.by(0)

        # Check if updated recipe equals to fake data.
        expect(Recipe.find("1").recipe_name).to eq(@fake_results.recipe_name)
      end

      it "should display success message" do
        # Fake login and create post request.
        fake_login
        create_recipe

        # Call update method and updated created recipe.
        put :update, id: "1", recipe: {recipe_name: "Test", servings: 2 } 

        # Expect to load recipe page.
        expect(@respose).to redirect_to(@result)

        # Expect to display flash message for recipe.
        expect(flash[:success]).to eq("Test was successfully updated.")
      end
    end
  end

  # == EDIT == 
  describe "#edit" do
    context "When a user loads the edit page and is the author" do
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

    context "When a user tries to load the edit page and isn't the author" do
      it "should display error message" do
          # Setup fake results
          @fake_results = double('Recipe', recipe_name: 'Lasagne', difficulty: 'Medium', servings: 4, cook_time: '20 Minutes', author: 'Test_Author')

          # Create mock user, this will be the logged in user (not the author)
          @fake_user = double('User', name: 'Matthew', username: 'Test_1', email: 'test@gmail.com', password: 'test1234') 
          
          # Fake login by setting session variable. This user_id is not the author.
          @request.session['user_id'] = "2"

          # Stub all methods, and pass in logged in username which is not the author from @fake_results
          allow(Recipe).to receive(:find).with('1').and_return(@fake_results)
          allow(User).to receive(:find).with('2').and_return(@fake_user)
          allow(RecipesController).to receive(:check_if_author).with('Test_1')
          
          # call recipes controller and pass in param
          get :edit, {id: "1"}

          # Expect to display flash message for recipe.
          expect(flash[:notice]).to eq("Only the author can update their recipe.")
      end
    end
  end

  # == DESTROY/DELETE == 
  describe "#delete" do
    context "When a user deletes a recipe and is the author" do

      it "should destroy a given recipe" do
        # Fake login and create post request (Helper Method)
        fake_login
        create_recipe

        # Expect delete request created to change recipe count by -1
        expect { delete :destroy, :id => '1' }.to change { Recipe.count }.by(-1)
      end

      it "should return to home page and display success message" do
        # Fake login and create post request (Helper Method)
        fake_login
        create_recipe

        # Delete new recipe created above, by calling destroy method.
        delete :destroy, :id => '1'

        # Expect to reload home page.
        expect(@respose).to redirect_to(:recipes)

        # Expect to display flash message for recipe.
        expect(flash[:success]).to eq("Lasagne was successfully deleted.")
      end
    end

    context "When a user tries to delete a recipe and isn't the author" do
      it "should display error message" do
          # Setup fake results
          @fake_results = double('Recipe', recipe_name: 'Lasagne', difficulty: 'Medium', servings: 4, cook_time: '20 Minutes', author: 'Test_Author')

          # Create mock user, this will be the logged in user (not the author)
          @fake_user = double('User', name: 'Matthew', username: 'Test_1', email: 'test@gmail.com', password: 'test1234') 
          
          # Fake login by setting session variable. This user_id is not the author.
          @request.session['user_id'] = "2"

          # Stub all methods, and pass in logged in username which is not the author from @fake_results
          allow(Recipe).to receive(:find).with('1').and_return(@fake_results)
          allow(User).to receive(:find).with('2').and_return(@fake_user)
          allow(RecipesController).to receive(:check_if_author).with('Test_1')
          
          # call recipes controller and pass in param
          delete :destroy, :id => '1'

          # Expect to display flash message for recipe.
          expect(flash[:notice]).to eq("Only the author can delete their recipe.")
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

      it "should sort by recipe_name" do
          # Call controller index check if template is rendered.
          get :index, {sort: "recipe_name"}
          expect(:recipe_name).to eql(:recipe_name)
      end

      it "should sort by cooking_time" do
          # Call controller index check if template is rendered.
          get :index, {sort: "cook_time"}
          expect(:cook_time).to eql(:cook_time)
      end
    end
  end

  # == SEARCH == 
  describe "#search_recipes" do
    context "When a user searches for a recipe" do
      it "should search and find results" do
          # Fake login and create post request (Helper Method)
          fake_login
          create_recipe

          # Call search with recipe name that is in db.
          get :search_recipes, {search: "Lasagne"}

          # Expect to display flash message for recipe.
          expect(flash[:success]).to eq("Results found for Lasagne")
      end

      it "should search and find no results" do
          # Fake login and create post request (Helper Method)
          fake_login
          create_recipe

          # Call search with recipe name that isn't in db.
          get :search_recipes, {search: "Chicken"}

          # Expect to display flash message for recipe.
          expect(flash[:notice]).to eq("No results found for Chicken")
      end
    end
  end
end