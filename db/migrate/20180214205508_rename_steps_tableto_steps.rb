class RenameStepsTabletoSteps < ActiveRecord::Migration[5.1]
  def up
    drop_table :steps
    rename_table :steps_tables, :steps
  end

  def down
    rename_table :steps, :steps_tables
    create_table :steps do |t|
      t.timestamps
    end
  end
end
