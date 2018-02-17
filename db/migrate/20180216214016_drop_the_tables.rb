class DropTheTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :foods_kitchens
    drop_table :kitchens

  end
end
