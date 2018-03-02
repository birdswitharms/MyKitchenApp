class CreateTableFoodKitchens < ActiveRecord::Migration[5.1]
  def up
    create_table :food_kitchens do |t|
      t.integer :food_id
      t.integer :kitchen_id
    end

    # remove_column :kitchens, :food_id
    # remove_column :kitchens, :instock
  end

  def down
    # add_column :kitchens, :food_id, :integer
    # add_column :kitchens, :instock, :boolean
    drop_table :food_kitchens
  end
end
