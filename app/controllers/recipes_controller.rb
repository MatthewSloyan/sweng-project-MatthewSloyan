class RecipesController < ApplicationController

  # Only allow access to index, and show until the user is logged in.
  # Code adapted from: https://stackoverflow.com/questions/1895645/ruby-on-rails-before-filter-only-when-user-is-logged-in
  before_filter :check_if_logged_in, except: [:index, :show, :search_recipes]

  # Check if user is logged in. If so allow, else display error message.
  def check_if_logged_in
    if session[:user_id]
      # Allow
    else
      flash[:notice] = "Please \"Log In\" or \"Sign Up\" to add, edit or delete recipes."
      redirect_to recipes_path
    end
  end

  # Validates creation of recipes request so that the data meets the requirments.
  # steps_attributes is used to validate the many steps a recipe can have. The same is used for ingredients_attributes
  def recipe_params
    params.require(:recipe).permit(:recipe_name, :description, :difficulty, :servings, :cook_time, :author, steps_attributes: [:id, :description, :_destroy], ingredients_attributes: [:id, :description, :_destroy])
  end

  def show
    id = params[:id] # retrieve recipe ID from URI route
    @recipe = Recipe.find(id) # look up recipe by unique ID
  end

  def index
    # Get sort information from session or parameters.
    sort = params[:sort] || session[:sort]
    case sort
    when 'recipe_name'
      ordering, @recipe_name_header = {:recipe_name => :asc}
    when 'cook_time'
      ordering, @cook_time_header = {:cook_time => :asc}
    end

    # Get all difficulty types
    @all_difficulties = Recipe.all_difficulties

    # Get selected difficulties from params or session data (If previously saved)
    @selected_difficulties = params[:difficulties] || session[:difficulties] || {}

    if @selected_difficulties == {}
      @selected_difficulties = Hash[@all_difficulties.map {|difficulty| [difficulty, difficulty]}]
    end

    # Update session details if not the same and reload
    if params[:sort] != session[:sort] or params[:difficulties] != session[:difficulties]
      session[:sort] = sort
      session[:difficulties] = @selected_difficulties
      redirect_to :sort => sort, :difficulties => @selected_difficulties and return
    end

    # Get all recipes based on user selection.
    # I initially had a search here instead of another page but I couldn't get it working with all params types.
    @recipes = Recipe.where(difficulty: @selected_difficulties.keys).order(ordering)
  end

  def new
    # Create a new object, and set up two step and ingredient boxes.
    @recipe = Recipe.new
    2.times {@recipe.steps.build}
    2.times {@recipe.ingredients.build}
  end

  def create
    # Create a new recipe using params. 
    # Then set user ID so that author can be set when creating the object.
    @recipe = Recipe.new(recipe_params)
    @recipe.set_user_id(session[:user_id])

    # Save the recipe to db or display error if not logged in.
    if @recipe.save
        flash[:success] = "#{@recipe.recipe_name} was successfully created."
        redirect_to recipes_path
    else
        flash[:notice] = "You need to be logged in to add a recipe."
        render "new"
    end
  end

  def edit
    # Find an existing recipe.
    @recipe = Recipe.find params[:id]

    # Check if the current signed in user is the author of the recipe, if not display error, if so edit.
    if !check_if_author(@recipe.author)
      flash[:notice] = "Only the author can update their recipe."
      redirect_to recipe_path(params[:id])
    else  
      @recipe
    end
  end

  def update 
    # Find an exiting recipe and update it's attributes.
    @recipe = Recipe.find params[:id]
    @recipe.update_attributes!(recipe_params)

    flash[:success] = "#{@recipe.recipe_name} was successfully updated."
    redirect_to recipe_path(@recipe)
  end

  def destroy
    # Find a recipe and destroy it's attributes and all associated data (Steps & ingredients)
    @recipe = Recipe.find(params[:id])

    # Check if the current signed in user is the author of the recipe, if not display error, if so delete.
    if !check_if_author(@recipe.author)
      flash[:notice] = "Only the author can delete their recipe."
      redirect_to recipe_path(params[:id])
    else  
      @recipe.destroy
    
      flash[:success] = "#{@recipe.recipe_name} was successfully deleted."
      redirect_to recipes_path
    end
  end

  # Check if search term is entered, if so search using search term else load all recipes.
  # Code adapted from: http://www.korenlc.com/creating-a-simple-search-in-rails-4/
  def search_recipes
    if params[:search]
      @recipes = Recipe.search(params[:search])

      # If no results are found redirect to home page.
      # Else found recipes are displayed.
      if @recipes.empty?
        flash[:notice] = "No results found for #{params[:search]}"
        redirect_to recipes_path
      else 
        flash[:success] = "Results found for #{params[:search]}"
      end
    end
  end

  # Check if the current signed in user is the author of a recipe.
  def check_if_author(author)
    if User.find(session[:user_id]).username == author
      true
    else  
      false
    end
  end
end
