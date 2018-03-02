class ChangeColumninRecipes < ActiveRecord::Migration[5.1]
  def up
    change_column :recipes, :image_url, :text
    change_column :recipes, :youtube_url, :text
  end

  def down
    change_column :recipes, :image_url, :string
    change_column :recipes, :youtube_url, :string
  end
end
