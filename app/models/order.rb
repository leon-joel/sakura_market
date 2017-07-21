class Order < ApplicationRecord
  include ApplicationHelper

  belongs_to :user

  has_many :order_products, -> { order "created_at ASC" },
           :inverse_of => :order    # ←これによってorder_productのorder_idカラムに正しい値がセットされるようになる https://stackoverflow.com/questions/16782990/rails-how-to-populate-parent-object-id-using-nested-attributes-for-child-obje
  accepts_nested_attributes_for :order_products, allow_destroy: true

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
      order.send_to_name = user.name
      order.send_to_address = user.address

      user.cart_products.each do |cp|
        order.order_products << OrderProduct.new(order: order, product: cp.product, quantity: cp.quantity)
      end
    end
  end

  # orderおよびorder_product行をINSERT＆カートをクリア＆COMMIT
  def self.create_and_clear_cart(user, param)
    Order.transaction do
      order = Order.create!(param.merge(user: user))

      # TODO: destroy_all! が無いらしいので、1つ1つ destroy! してる…
      user.cart_products.each do |cp|
        cp.destroy!
      end

      order
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

  def delivery_time_range_string
    time_range_to_string(self.delivery_time_range)
  end

end
