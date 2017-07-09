class Order < ApplicationRecord
  belongs_to :user

  has_many :order_products, -> { order "created_at ASC" }

  def total
    order_products.inject(0) {|sum, op| sum + op.subtotal }
  end
end
