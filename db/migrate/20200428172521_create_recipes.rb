class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.text :description
      t.string :difficulty
      t.integer :servings
      t.string :cook_time
      t.string :author

      t.timestamps
    end
  end

  def down
    drop_table :recipes
  end
end
