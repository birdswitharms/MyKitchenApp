class CreateReceipesStepsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :receipes_steps_tables do |t|
      t.references :step, foreign_key: true
      t.references :recipes, foreign_key: true
    end
  end
end
