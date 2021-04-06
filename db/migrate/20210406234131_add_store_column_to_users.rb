class AddStoreColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :store, :string
  end
end
