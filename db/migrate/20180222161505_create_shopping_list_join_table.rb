class CreateShoppingListJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :shoppinglists do |t|
      t.references :user, foreign_key: true
      t.references :foods, foreign_key: true
      t.timestamps
    end
  end
end
