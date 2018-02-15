class RemoveInstructionsColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :instructions
  end
end
