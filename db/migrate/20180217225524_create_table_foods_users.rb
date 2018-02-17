class CreateTableFoodsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :table_foods_users do |t|
      t.references :food_id, foreign_key: true
      t.references :user_id, foreign_key: true
    end
  end
end
