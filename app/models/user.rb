class User < ApplicationRecord
  has_many :orders, -> { order "created_at DESC" }
  has_many :cart_products, -> { order "created_at DESC" }

  # カートはともかく、注文（履歴）が残っている限りユーザーを削除出来ないようにするため、dependentオプションは付けない。
  # DB側制約 DELETE NO ACTION により必ず削除がエラーになる。
  # TASK: :restrict_with_exception を付けた場合との振る舞いの違いは要確認。

end
