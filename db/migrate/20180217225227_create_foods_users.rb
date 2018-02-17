class CreateFoodsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :foods_users do |t|
      t.references :user_id, foreign_key: true
      t.references :food_id, foreign_key: true

      t.timestamps
    end
  end
end
