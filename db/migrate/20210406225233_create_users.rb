class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :pasword_digest
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end