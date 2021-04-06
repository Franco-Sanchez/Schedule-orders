class Store < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :orders, dependent: :nullify
  has_and_belongs_to_many :products
end
