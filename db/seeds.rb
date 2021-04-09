# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Start creating products'
(1..5).each { Product.create(name: Faker::Commerce.unique.product_name) }
puts 'End creating products'

puts 'Start creating stores'
(1..5).each { Store.create(name: Faker::Company.unique.name, priority: rand(1..5)) }
puts 'End creating stores'

stores = Store.all
products = Product.all

puts 'Start adding products to the store'
stores.each do |store|
  products.first(rand(1..5)).each do |product|
    store.products << product
  end
end
puts 'End adding products to the store'

puts 'Start creating user by store'
stores.each do |store|
  store_email = store.name.split(/-|\s|,/).first.downcase
  puts store_email
  User.create(username: Faker::Lorem.unique.word, email: "#{store_email}@mail.com", 
              password: '123456', store_name: store.name, store: store)
end
puts 'End creating user by store'