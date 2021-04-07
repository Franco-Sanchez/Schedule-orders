class ChangeProductColumnNameOnOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :product, :product_name
  end
end
