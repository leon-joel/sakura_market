class Order < ApplicationRecord
  belongs_to :user

  has_many :order_products, -> { order "created_at ASC" }

  # userのカートの内容からOrderを生成する
  # カートの中身が0の場合はnilを返す。
  def self.new_from_user(user)
    # カートの内容を取得し、Orderに詰め込む
    # if user.cart_products.count == 0     # countは SELECT count(*) が走る。★キャッシュなし
    # if user.cart_products.size == 0      # sizeは SELECT count(*) が走る ※キャッシュあり
    if user.cart_products.length == 0      # lengthは SELECT * が走る。※キャッシュあり。つまり、次の user.cart_productへのアクセス時にはSQLが走らない。 http://www.lanches.co.jp/blog/3199
      return nil
    end

    order = Order.new(user: user)
    user.cart_products.each do |cp|
      order.order_products << OrderProduct.new(order: @order, product: cp.product, quantity: cp.quantity)
    end

    order
  end

  def total
    order_products.inject(0) {|sum, op| sum + op.subtotal }
  end
end
