class ChangeStoreColumnNameOnUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :store, :store_name
  end
end
