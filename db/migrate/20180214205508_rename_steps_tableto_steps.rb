class RenameStepsTabletoSteps < ActiveRecord::Migration[5.1]
  def change
    drop_table :steps
    rename_table :steps_tables, :steps
  end
end
