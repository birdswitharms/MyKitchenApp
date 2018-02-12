class CreateKitchens < ActiveRecord::Migration[5.1]
  def change
    create_table :kitchens do |t|
      t.references :user, foreign_key: true
      t.references :food, foreign_key: true
      t.boolean :instock

      t.timestamps
    end
  end
end
