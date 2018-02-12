class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.references :food, foreign_key: true
      t.references :recipe, foreign_key: true
      t.string :measurement_unit
      t.float :quantity

      t.timestamps
    end
  end
end
