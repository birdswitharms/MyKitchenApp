class RemoveInstructionsColumn < ActiveRecord::Migration[5.1]
  def up
    remove_column :recipes, :instructions
  end
  def down
    add_column :recipes, :instructions, :text
  end
end
