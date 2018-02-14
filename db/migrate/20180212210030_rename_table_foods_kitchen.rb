class RenameTableFoodsKitchen < ActiveRecord::Migration[5.1]
  def change
    rename_table :food_kitchens, :foods_kitchens
  end
end
