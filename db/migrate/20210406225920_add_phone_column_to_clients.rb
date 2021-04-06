class AddPhoneColumnToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :phone, :string
  end
end
