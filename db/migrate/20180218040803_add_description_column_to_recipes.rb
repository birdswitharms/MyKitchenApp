class AddDescriptionColumnToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :description, :text
  end
end
