class AddReviewTable < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :recipe, foreign_key: true
      t.references :user, foreign_key: true
      t.text :comment
      t.timestamps
    end
  end
end
