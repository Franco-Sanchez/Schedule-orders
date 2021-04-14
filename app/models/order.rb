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
      # next unless confirm_two_hours(order)

      order.update(status: 'discarded')
      create_order(order)
    end
  end

  def self.create_order(order)
    store = store_found(order.product_name, order.store)
    if store.is_a?(Array)
      OrderMailer.with(client: order.client).order_discarded_email.deliver_now
    else
      create(price: order.price, product_name: order.product_name, client: order.client,
             store: store)
    end
  end

  def self.store_found(product_name, store_object = nil)
    stores = Store.all
    stores_filter = stores.filter do |store|
      store.products.filter { |product| product.name == product_name }.size.positive?
    end
    if saved_stores(stores_filter, store_object).length.positive?
      saved_stores(stores_filter, store_object).first
    else
      saved_stores(stores_filter, store_object)
    end
  end

  def self.saved_stores(stores_filter, store_object)
    if store_object
      stores_sort = stores_filter.sort_by(&:priority)
      store_index = stores_sort.index(store_object)
      stores_sort.filter { |store| stores_sort.index(store) > store_index }
    else
      stores_filter.sort_by(&:priority)
    end
  end

  def self.confirm_two_hours(order)
    current_time = (DateTime.now.hour * 60) + DateTime.now.min
    save_time = (order.created_at.hour * 60) + order.created_at.min
    (current_time - save_time) / 60 == 2
  end

  # custom validation

  private

  def price_approved
    errors.add(:price, 'Price should be greater than 0') if price && price <= 0
  end
end
