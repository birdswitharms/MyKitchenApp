class RemoveDescriptionAddRecipeUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :description
  end
end
