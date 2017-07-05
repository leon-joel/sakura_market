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
end
