class RecipesController < ApplicationController

  def movie_params
    params.require(:recipe).permit(:recipe_name, :description, :difficulty, :servings, :cook_time, :steps, :ingredients, :author)
  end

  def show
    id = params[:id] # retrieve recipe ID from URI route
    @recipe = Recipe.find(id) # look up recipe by unique ID
    # will render app/views/recipes/show.<extension> by default
  end

  def index
    @recipes = Recipe.all
  end

  def new
    # default: render 'new' template
  end
end
