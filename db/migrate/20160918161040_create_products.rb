class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :manufacturer
      t.float :price, precision: 2
      t.integer :quantity
      t.string :image

      t.timestamps null: false
    end
  end
end
