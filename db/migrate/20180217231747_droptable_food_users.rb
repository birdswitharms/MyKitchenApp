class DroptableFoodUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :foods_users
  end
end
