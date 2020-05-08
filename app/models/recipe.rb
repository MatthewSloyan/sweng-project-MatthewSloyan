class Recipe < ActiveRecord::Base
    # Each recipe will have many steps, if recipe is destroyed steps are too.
    has_many :steps, inverse_of: :recipe
    accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

    #serialize :steps, Array
    #serialize :ingredients, Array

    #accepts_nested_attributes_for :steps, :ingredients, allow_destroy: true

    def self.all_difficulties
        %w(Easy Medium Hard)
    end

    # Searches recipe by name and description. 
    # Code adapted from: http://www.korenlc.com/creating-a-simple-search-in-rails-4/
    def self.search(search)
      where("recipe_name LIKE ?", "%#{search}%") 
      where("description LIKE ?", "%#{search}%")
    end
end
