class DropRecipeStepsTableAddColumnToStepsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :receipes_steps_tables
    add_column :steps, :recipe_id, :integer
  end
end
