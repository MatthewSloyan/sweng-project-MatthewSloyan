class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.text :description
      t.integer :difficulty
      t.integer :servings
      t.string :prep_time
      t.text :steps
      t.text :ingredients
      t.string :author

      t.timestamps
    end
  end

  def down
    drop_table :recipes
  end
end
