class CreateAppliancesRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :appliances_recipes do |t|
      t.references :appliance, foreign_key: true
      t.references :recipe, foreign_key: true
      t.timestamps
    end
  end
end
