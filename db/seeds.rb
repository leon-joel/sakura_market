# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

product1 = Product.create({ name: "おたんこなすび", picture: "otanko.jpg", price: 722, description: "世界一まずいなすび", is_visible: true, display_order: 1})
product2 = Product.create({ name: "オバキュウリ", price: 890})

user1 = User.create({name: "User1", email: "user1@example.com", password: "abc", address: "東京"})
user2 = User.create({name: "User2", email: "user2@example.com", password: ""})

order1 = Order.create({ user: user1, order_datetime: DateTime.current - 1.day, send_to: "千葉", date_to_deliver: Date.current + 1.day, time_range_to_deliver: "16-18"})
order2 = Order.create({ user: user1, order_datetime: DateTime.current, send_to: "鹿児島県"})

order1_product1 = OrderProduct.create( { order: order1, product: product1, sales_price: 1001, quantity: 1})
order1_product2 = OrderProduct.create( { order: order1, product: product2, sales_price: 1002, quantity: 2})

order2_product1 = OrderProduct.create( { order: order1, product: product2, sales_price: 1003, quantity: 3})
