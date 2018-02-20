class RenameTableFoodsUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :table_foods_users
  end
end
