class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :description
      t.belongs_to :recipe, index: true, foreign_key: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :ingredients
  end
end
