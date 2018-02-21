class ChangeColumninRecipes < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :image_url, :text
    change_column :recipes, :youtube_url, :text
  end
end
