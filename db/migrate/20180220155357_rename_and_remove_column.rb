class RenameAndRemoveColumn < ActiveRecord::Migration[5.1]
  def up
    rename_table :foods_users, :pantry
    remove_column :ingredients, :recipe_id
  end

  def down
    rename_table :pantry, :foods_users
    add_column :ingredients, :recipe_id, :integer
  end
end
