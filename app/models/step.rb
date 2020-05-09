class Step < ActiveRecord::Base
  # A recipe can have multiple steps.
  # Each step has an ID which associated with each Recipe.
  belongs_to :recipe
end
