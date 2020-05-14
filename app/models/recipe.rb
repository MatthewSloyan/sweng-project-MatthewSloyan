class Recipe < ActiveRecord::Base
    # Each recipe will have many steps, if recipe is destroyed steps are too.
    # Nested attributes allow multiple steps to be created or destroyed.
    has_many :steps, inverse_of: :recipe, :dependent => :destroy
    has_many :ingredients, inverse_of: :recipe, :dependent => :destroy
    accepts_nested_attributes_for :steps, :ingredients, reject_if: :all_blank, allow_destroy: true

    # Before information is written to database set author, only when creating.
    # Code adapted from: https://stackoverflow.com/questions/23860329/understanding-before-save-in-ruby-rails
    before_save :set_user_name, :if => :new_record?

    def self.all_difficulties
        %w(Easy Medium Hard)
    end

    # Searches recipe by name and description. 
    # Code adapted from: http://www.korenlc.com/creating-a-simple-search-in-rails-4/
    def self.search(search)
     
      # First search by recipe_name, then if not found try to search by description.
      recipes = where("recipe_name LIKE ?", "%#{search}%")
      if !recipes.empty?
        return recipes
      elsif recipes = where("description LIKE ?", "%#{search}%")
        return recipes
      end 
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
        self.author = 'Test_Author'
      end
    end

    # Method that finds all recipes with the same author.
    # .where finds all the Recipes with a author of the author passed in.
    # Code adapted from: https://www.rubyguides.com/2019/07/rails-where-method/
    def self.find_by_author(author)
      where(author: author)
    end
end
