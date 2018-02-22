class ChangeColumnInShoppingListTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :shoppinglists, :foods_id, :food_id
  end
end
