class CreateFoodsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :foods_users do |t|
      t.belongs_to :user
      t.belongs_to :food

      t.timestamps
    end
  end
end
