class AlterItems < ActiveRecord::Migration
  def change
    add_column :items, :itemable_id, :integer
    add_column :items, :itemable_type, :string
    remove_column :items, :cart_id
    add_index :items, [:itemable_id, :itemable_type]
  end
end
