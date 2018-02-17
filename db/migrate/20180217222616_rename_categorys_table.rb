class RenameCategorysTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :categorys, :categories
  end
end
