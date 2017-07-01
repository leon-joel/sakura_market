class Order < ApplicationRecord
  belongs_to :user

  has_many :order_products, -> { order "created_at ASC" }
end
