class Store < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :orders, dependent: :nullify
  has_and_belongs_to_many :products

  validates :name, presence: true, uniqueness: true
  validates :priority, numericality: { only_integer: true, greater_than: 0 }
end
