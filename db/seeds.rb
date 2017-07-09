# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Inserting seed data..."

product1 = Product.create({ name: "おたんこなすび", picture: "nasu-150x150.jpg", price: 722, description: "世界一まずいなすび", is_visible: true, display_order: 1})
product2 = Product.create({ name: "オバキュウリ", picture: "green-150x150.jpg", price: 890})
product3 = Product.create({ name: "リコピンたっぷり新鮮トマト", picture: "red-150x150.jpg", price: 345, description: "これを食べずしてトマトを語るなかれ", is_visible: true})

user1 = User.create({name: "User1", email: "user1@example.com", password: "abc", password_confirmation: "abc", address: "東京"})
user2 = User.create({name: "User2", email: "user2@example.com", password: " ", password_confirmation: " " })
user3 = User.create({name: "User3", email: "user3@example.com", password: "xyz", password_confirmation: "xyz" })

order1 = Order.create({ user: user1, send_to_address: "千葉", deliver_date: Date.current + 1.day, deliver_time_range: "16-18"})
order2 = Order.create({ user: user1, send_to_address: "鹿児島県"})

order1_product1 = OrderProduct.create( { order: order1, product: product1, sales_price: 1001, quantity: 1})
order1_product2 = OrderProduct.create( { order: order1, product: product2, sales_price: 1002, quantity: 2})

order2_product1 = OrderProduct.create( { order: order1, product: product2, sales_price: 1003, quantity: 3})

CartProduct.create( { user: user1, product: product1, quantity: 3 })

CartProduct.create( { user: user2, product: product1 })
CartProduct.create( { user: user2, product: product2, quantity: 2 })

puts "Finished inserting seed data."
