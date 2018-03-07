class RenameStepsTabletoSteps < ActiveRecord::Migration[5.1]
  def change
    rename_table :weekly_planner, :weekly_planners
  end
end
