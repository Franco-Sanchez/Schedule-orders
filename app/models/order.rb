class Order < ApplicationRecord
  belongs_to :client
  belongs_to :store

  enum status: { pending: 0, approved: 1, discarded: 2 }

  validates :product_name, presence: true
  validate :price_approved

  def self.pending_orders
    pending_orders = where(status: 'pending')
    return unless pending_orders.length.positive?

    pending_orders.each do |order|
      order.update(status: 'discarded')
      unless store_found(order.product_name, order.store).is_a?(Array)
        create(price: order.price, product_name: order.product_name, client: order.client,
               store: store_found(order.product_name, order.store))
      end
    end
  end

  def self.store_found(product_name, store_object = nil)
    stores = Store.all
    stores_filter = stores.filter do |store|
      store.products.filter { |product| product.name == product_name }.size.positive?
    end
    if validate_store_object(stores_filter, store_object).length.positive?
      validate_store_object(stores_filter, store_object).first
    else
      validate_store_object(stores_filter, store_object)
    end
  end

  def self.validate_store_object(stores_filter, store_object)
    if store_object
      stores_sort = stores_filter.sort_by(&:priority)
      store_index = stores_sort.index(store_object)
      stores_sort.filter { |store| stores_sort.index(store) > store_index }
    else
      stores_filter.sort_by(&:priority)
    end
  end

  def price_approved
    errors.add(:price, 'Price should be greater than 0') if price && price <= 0
  end
end
