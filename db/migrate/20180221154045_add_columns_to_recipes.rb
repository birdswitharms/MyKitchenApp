class AddColumnsToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :image_url, :string
    add_column :recipes, :youtube_url, :string
  end
end
