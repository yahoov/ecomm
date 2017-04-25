class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :cart_id
      t.integer :product_id
      t.integer :quantity, default: 0

      t.timestamps null: false
    end

    add_index :items, [:cart_id, :product_id]
  end
end
