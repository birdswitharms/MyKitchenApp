class DropTheTables < ActiveRecord::Migration[5.1]
  def up
    drop_table :foods_kitchens
    drop_table :kitchens
  end

  def down
    create_table :foods_kitchens do |t|
      t.integer :food_id
      t.integer :kitchen_id
    end

    create_table :kitchens do |t|
      t.references :user, foreign_key: true
      t.references :food, foreign_key: true
      t.boolean :instock
      t.timestamps
    end
  end
end
