class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.float :quantity
      t.string :maker

      t.timestamps null: false
    end

    add_index :products, :name
  end
end
