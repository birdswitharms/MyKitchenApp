class CreateTableFoodKitchens < ActiveRecord::Migration[5.1]
  def change
    create_table :food_kitchens do |t|
      t.integer :food_id
      t.integer :kitchen_id
    end

    remove_column :kitchens, :food_id
    remove_column :kitchens, :instock
  end

end
