class User < ApplicationRecord
  has_secure_password

  belongs_to :store

  validates :username, :email, :store, presence: true
  validates :username, :email, uniqueness: true
  validates :email, format: { with: /\A\w+@\w+\.\w{2,3}\z/ }
  validates :password, length: { minimum: 6 }
end
