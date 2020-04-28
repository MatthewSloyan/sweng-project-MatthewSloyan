class Recipe < ActiveRecord::Base
    serialize :steps, Array
    serialize :ingredients, Array
end
