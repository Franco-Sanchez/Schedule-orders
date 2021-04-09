class Order < ApplicationRecord
  belongs_to :client
  belongs_to :store

  enum status: { pending: 0, approved: 1, discarded: 2 }

  validates :product_name, presence: true
  validate :price_approved

  def self.store_found(product_name, store_id = nil)
    stores = Store.all
    stores_filter = stores.filter do |store|
      store.products.filter { |product| product.name == product_name }.size.positive?
    end
    stores_filter.delete_if { |store| store.id == store_id } if store_id
    stores_order_priority = stores_filter.sort_by(&:priority)
    stores_order_priority.first
  end

  def price_approved
    return unless status == 'approved' && (!price || price <= 0)

    errors.add(:price, 'Price should exist or be greater than 0')
  end
end
