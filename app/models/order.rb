class Order < ApplicationRecord
  belongs_to :client
  belongs_to :store

  enum status: { pending: 0, approved: 1, canceled: 2 }

  validates :product, presence: true
end
