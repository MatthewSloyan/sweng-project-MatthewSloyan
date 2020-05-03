class Recipe < ActiveRecord::Base
    serialize :steps, Array
    serialize :ingredients, Array

    def self.all_difficulties
        %w(Easy Medium Hard)
    end
end
