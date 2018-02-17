class RenameStepColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :steps, :step, :content

  end
end
