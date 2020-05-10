class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :password_salt

      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
