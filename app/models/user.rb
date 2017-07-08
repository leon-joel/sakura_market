class User < ApplicationRecord
  has_secure_password   # bcrypt

  has_many :orders, -> { order "created_at DESC" }
  has_many :cart_products, -> { order "created_at DESC" }

  # カートはともかく、注文（履歴）が残っている限りユーザーを削除出来ないようにするため、dependentオプションは付けない。
  # DB側制約 DELETE NO ACTION により必ず削除がエラーになる。
  # TODO: :restrict_with_exception を付けた場合との振る舞いの違いは要確認。

  # passwordのsetter
  # 生パスワードを与えると、それをハッシュ化して password_digest に代入する
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.password_digest = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password_digest = nil
    end
  end

  # TODO: 検討: 操作しているのは cart_productsテーブルだけなので、元々の設計通り CartProductモデルに実装すべきか？？？
  def add_to_cart!(product_id)
    # TODO: （ココだけではないが）排他制御とか考えないといけないかな… 最初のSELECT時に SELECT FOR UPDATE するとか？？？ 一人で複数デバイス使えることまで考えると…
    cart_product = CartProduct.find_by_user_id_and_product_id(self, product_id)
    if cart_product
      # 同じ商品が既にカートに入っている場合には、その数量を +1 する
      cart_product.update!({ quantity: cart_product.quantity + 1 })
    else
      # 入っていない場合には、普通に INSERT する
      cart_product = CartProduct.create!({user: self, product_id: product_id, quantity: 1})
    end
    cart_product
  end


end
