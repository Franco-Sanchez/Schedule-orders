class AddIndexToStores < ActiveRecord::Migration[6.1]
  def change
    add_index :stores, :name, unique: true
  end
end
