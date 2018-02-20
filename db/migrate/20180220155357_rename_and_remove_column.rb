class RenameAndRemoveColumn < ActiveRecord::Migration[5.1]
  def change
    rename_table :foods_users, :pantry
    remove_column :ingredients, :recipe_id
  end
end
