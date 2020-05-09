class Ingredient < ActiveRecord::Base
  # A recipe can have multiple ingredients.
  # Each step has an ID which associated with each Recipe.
  belongs_to :recipe
end
