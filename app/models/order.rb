class Order < ApplicationRecord
  belongs_to :client
  belongs_to :store

  enum status: { pending: 0, approved: 1, canceled: 2 }

  validates :product_name, presence: true

  def self.store_found(product_name)
    stores = Store.all
    stores_filter = stores.filter do |store|
      store.products.filter { |product| product.name == product_name }.size.positive?
    end
    stores_order_priority = stores_filter.sort_by(&:priority)
    stores_order_priority.first
  end
end
