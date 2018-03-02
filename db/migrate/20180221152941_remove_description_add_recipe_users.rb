class RemoveDescriptionAddRecipeUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :recipes, :description
  end

  def down
    add_column :recipes, :description, :text
  end
end
