class RenameTableFoodsUsers < ActiveRecord::Migration[5.1]
  def up
    drop_table :table_foods_users
  end

  def down
    create_table :table_foods_users do |t|
      t.belongs_to :food
      t.belongs_to :user
    end
  end
end
