class RenametabletableFoodsUsers2s < ActiveRecord::Migration[5.1]
  def change
    rename_table :table_foods_users2s, :foods_users
  end
end
