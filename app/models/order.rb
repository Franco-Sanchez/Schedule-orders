class Order < ApplicationRecord
  belongs_to :client
  belongs_to :store

  enum status: { pending: 0, approved: 1, discarded: 2 }

  validates :product_name, presence: true
  validate :price_approved

  def self.store_found(product_name, store_object = nil)
    stores = Store.all
    stores_filter = stores.filter do |store|
      store.products.filter { |product| product.name == product_name }.size.positive?
    end
    validate_store_object(stores_filter, store_object).first
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
    return unless status == 'approved' && (!price || price <= 0)

    errors.add(:price, 'Price should exist or be greater than 0')
  end
end
