class AddNutritionColumnsToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :calories, :float
    add_column :ingredients, :total_fat, :float
    add_column :ingredients, :saturated_fat, :float
    add_column :ingredients, :cholesterol, :float
    add_column :ingredients, :sodium, :float
    add_column :ingredients, :potassium, :float
    add_column :ingredients, :total_carbohydrates, :float
    add_column :ingredients, :dietary_fiber, :float
    add_column :ingredients, :sugars, :float
    add_column :ingredients, :protein, :float
  end
end
