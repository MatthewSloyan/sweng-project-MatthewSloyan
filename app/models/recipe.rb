class Recipe < ActiveRecord::Base
    # Each recipe will have many steps, if recipe is destroyed steps are too.
    # Nested attributes allow multiple steps to be created or destroyed.
    has_many :steps, inverse_of: :recipe
    has_many :ingredients, inverse_of: :recipe
    accepts_nested_attributes_for :steps, :ingredients, reject_if: :all_blank, allow_destroy: true

    # Before information is written to database.
    # Code adapted from: https://stackoverflow.com/questions/23860329/understanding-before-save-in-ruby-rails
    before_save :set_user_name

    def self.all_difficulties
        %w(Easy Medium Hard)
    end

    # Searches recipe by name and description. 
    # Code adapted from: http://www.korenlc.com/creating-a-simple-search-in-rails-4/
    def self.search(search)
      where("description LIKE ?", "%#{search}%")
      where("recipe_name LIKE ?", "%#{search}%") 
    end

    # Instance variable used to pass
    @user_id = nil;

    def set_user_id(id)
      @user_id = id
    end

    # Sets username of recipe just before it is saved to the database.
    # The username is the logged in user.
    # If true it is saved, if falsed an error is displayed.
    def set_user_name
      if @user_id
        self.author = User.find(@user_id).username
        true
      else 
        false
      end
    end
end
