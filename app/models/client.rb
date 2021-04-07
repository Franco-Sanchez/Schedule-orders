class Client < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, :email, :address, presence: true
  validates :email, format: { with: /\A\w+@\w+\.\w{2,3}\z/ }
end
