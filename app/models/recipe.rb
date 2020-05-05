class Recipe < ActiveRecord::Base
    serialize :steps, Array
    serialize :ingredients, Array

    def self.all_difficulties
        %w(Easy Medium Hard)
    end

    accepts_nested_attributes_for :steps, :ingredients, allow_destroy: true
end
