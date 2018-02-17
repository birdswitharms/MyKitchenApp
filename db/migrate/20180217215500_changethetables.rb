class Changethetables < ActiveRecord::Migration[5.1]
  def change

    create_table :categorys do |t|

      t.string :name
    end

    add_column :foods, :category_id, :integer
    drop_table :kitchens
    drop_table :foods_kitchens
  end
end
