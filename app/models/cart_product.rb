class CartProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def self.of_user(user)
    where(user_id: user.id).order(created_at: :desc)
  end


  def self.insert_or_increment(user, product)
    # TODO: 排他制御とか考えないといけないかな… 最初のSELECT時に SELECT FOR UPDATE するとかすべきか？ 一人で複数デバイス使えることまで考えると…
    cart_product = CartProduct.find_by_user_id_and_product_id(user, product)
    if cart_product
      # 同じ商品が既にカートに入っている場合には、その数量を +1 する
      result = cart_product.update({ quantity: cart_product.quantity + 1 })
    else
      # 入っていない場合には、普通に INSERT する
      cart_product = CartProduct.new({user: user, product: product, quantity: 1})
      result = cart_product.save
    end

    # TODO: 複数の値を返しているが、、、もうちょっとスマートな分かりやすい方法はないものかな？？ （Rubyだから見た目はスマートだけど…）
    return result, cart_product
  end
end
