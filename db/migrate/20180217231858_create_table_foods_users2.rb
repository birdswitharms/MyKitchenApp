class CreateTableFoodsUsers2 < ActiveRecord::Migration[5.1]
  def change
    create_table :foods_users do |t|
      t.references :food, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
