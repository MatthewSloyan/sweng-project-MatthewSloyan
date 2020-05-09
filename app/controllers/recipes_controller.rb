class RecipesController < ApplicationController

  # Validates creation of recipes request so that the data meets the requirments.
  # steps_attributes is used to validate the many steps a recipe can have. The same is used for ingredients_attributes
  def recipe_params
    params.require(:recipe).permit(:recipe_name, :description, :difficulty, :servings, :cook_time, :author, steps_attributes: [:id, :description, :_destroy], ingredients_attributes: [:id, :description, :_destroy])
  end

  def show
    id = params[:id] # retrieve recipe ID from URI route
    @recipe = Recipe.find(id) # look up recipe by unique ID
    # will render app/views/recipes/show.<extension> by default
  end

  def index
    #session.delete(:difficulties)
    #session.delete(:sort)

    # Get sort information from session or parameters.
    sort = params[:sort] || session[:sort]
    case sort
    when 'recipe_name'
      ordering, @recipe_name_header = {:recipe_name => :desc}
    when 'cook_time'
      ordering, @cook_time_header = {:cook_time => :desc}
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

    # Check if search term is entered, if so search using search term else load all recipes.
    # Code adapted from: http://www.korenlc.com/creating-a-simple-search-in-rails-4/
    if params[:search]
      @recipes = Recipe.search(params[:search]).order(ordering)

      if @recipes.empty?
        flash[:notice] = "No results found for #{params[:search]}"
        @recipes = Recipe.where(difficulty: @selected_difficulties.keys).order(ordering)
      else 
        flash[:notice] = "Results found for #{params[:search]}"
      end
    else
      # Get all recipes based on selection.
      @recipes = Recipe.where(difficulty: @selected_difficulties.keys).order(ordering)
    end
  end

  def new
    # Create a new object, and set up two step and ingredient boxes.
    @recipe = Recipe.new
    2.times {@recipe.steps.build}
    2.times {@recipe.ingredients.build}
  end

  def create
    # Create a new recipe and save to database.
    @recipe = Recipe.create!(recipe_params)

    flash[:notice] = "#{@recipe.recipe_name} was successfully created."
    redirect_to recipes_path
  end

  def edit
    # Find an existing recipe.
    @recipe = Recipe.find params[:id]
  end

  def update
    # Find an exiting recipe and update it's attributes.
    @recipe = Recipe.find params[:id]
    @recipe.update_attributes!(recipe_params)

    flash[:notice] = "#{@recipe.recipe_name} was successfully updated."
    redirect_to recipe_path(@recipe)
  end

  def destroy
    # Find a recipe and destroy it's attributes and all associated data (Steps & ingredients)
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    
    flash[:notice] = "#{@recipe.recipe_name} was successfully deleted."
    redirect_to recipes_path
  end
end
