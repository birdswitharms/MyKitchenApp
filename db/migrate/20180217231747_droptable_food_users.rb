class DroptableFoodUsers < ActiveRecord::Migration[5.1]
  def up
    drop_table :foods_users
  end
  def down
    create_table :foods_users do |t|
      t.belongs_to :user
      t.belongs_to :food
      t.timestamps
    end
  end
end
