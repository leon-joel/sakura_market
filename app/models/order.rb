class Order < ApplicationRecord
  belongs_to :user

  has_many :order_products, -> { order "created_at ASC" }

  # userのカートの内容からOrderを生成する
  # カートが空の場合はnilを返す。
  def self.new_from_cart(user)
    # カートの内容を取得し、Orderに詰め込む
    # if user.cart_products.count == 0     # countは SELECT count(*) が走る。★キャッシュなし
    # if user.cart_products.size == 0      # sizeは SELECT count(*) が走る ※キャッシュあり
    if user.cart_products.length == 0      # lengthは SELECT * が走る。※キャッシュあり。つまり、次の user.cart_productへのアクセス時にはSQLが走らない。 http://www.lanches.co.jp/blog/3199
      return nil
    end

    Order.new(user: user) do |order|
      user.cart_products.each do |cp|
        order.order_products << OrderProduct.new(order: order, product: cp.product, quantity: cp.quantity)
      end
    end
  end

  def products_total
    order_products.sum(&:subtotal)
  end
  def grand_total
    products_total + postage + cod_fee + tax
  end

  def total_quantity
    order_products.sum(&:quantity)
  end

  # 送料
  def postage
    Order.calc_postage(total_quantity)
  end
  def self.calc_postage(item_num)
    600 * ((item_num + 4) / 5)
  end

  # 代引き手数料
  def cod_fee
    Order.calc_cod_fee(products_total)
  end
  def self.calc_cod_fee(total_price)
    if total_price == 0
      0
    elsif total_price < 10000
      300
    elsif total_price < 30000
      400
    elsif total_price < 100000
      600
    else
      1000
    end
  end

  def tax
    Order.calc_tax(products_total + postage + cod_fee)
  end
  def self.calc_tax(total)
    (total * 0.08).floor
  end

end
