class CreateTableWeeklyPlanner < ActiveRecord::Migration[5.1]
  def change
    create_table :weekly_planners do |t|
      t.references :recipe, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :position
    end
  end
end
