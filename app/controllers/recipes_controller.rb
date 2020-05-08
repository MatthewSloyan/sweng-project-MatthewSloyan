class RecipesController < ApplicationController

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

    # Get all difficulty types
    @all_difficulties = Recipe.all_difficulties

    # Get selected difficulties from params or session data (If previously saved)
    @selected_difficulties = params[:difficulties] || session[:difficulties] || {}

    if @selected_difficulties == {}
      @selected_difficulties = Hash[@all_difficulties.map {|difficulty| [difficulty, difficulty]}]
    end

    # Update session details if not the same and reload
    if params[:difficulties] != session[:difficulties]
      session[:difficulties] = @selected_difficulties
      redirect_to :difficulties => @selected_difficulties and return
    end

    # Check if search term is entered, if so search using search term else load all recipes.
    # Code adapted from: http://www.korenlc.com/creating-a-simple-search-in-rails-4/
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC")

      if @recipes.empty?
        flash[:notice] = "No results found for #{params[:search]}"
        @recipes = Recipe.where(difficulty: @selected_difficulties.keys)
      else 
        #session.delete(:difficulties)
        @recipes = Recipe.where(difficulty: @selected_difficulties.keys)
      end
    else
      # Get all recipes based on selection.
      @recipes = Recipe.where(difficulty: @selected_difficulties.keys)
    end
  end

  def new
    @recipe = Recipe.new
    2.times {@recipe.steps.build}
    2.times {@recipe.ingredients.build}
  end

  def create
    @recipe = Recipe.create!(recipe_params)

    flash[:notice] = "#{@recipe.recipe_name} was successfully created."
    redirect_to recipes_path
  end

  def edit
    @recipe = Recipe.find params[:id]
  end

  def update
    @recipe = Recipe.find params[:id]
    @recipe.update_attributes!(recipe_params)
    flash[:notice] = "#{@recipe.recipe_name} was successfully updated."
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = "#{@recipe.recipe_name} was successfully deleted."
    redirect_to recipes_path
  end
end
