class RecipesController < ApplicationController

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :description, :difficulty, :servings, :cook_time, :steps, :ingredients, :author)
  end

  def show
    id = params[:id] # retrieve recipe ID from URI route
    @recipe = Recipe.find(id) # look up recipe by unique ID
    # will render app/views/recipes/show.<extension> by default
  end

  def index
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

    # Get all recipes based on selection.
    @recipes = Recipe.where(difficulty: @selected_difficulties.keys)
  end

  def new
    # default: render 'new' template
  end

  def create
    @recipe = Recipe.create!(recipe_params)
    flash[:notice] = "#{@recipe.recipe_name} was successfully created."
    redirect_to recipes_path
  end
end
