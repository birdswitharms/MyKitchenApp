class CreateStepsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :steps_tables do |t|
      t.text :step
    end
  end
end
