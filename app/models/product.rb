class Product < ApplicationRecord
  has_many :cart_products
  has_many :order_products

  scope :to_display, -> { where(is_visible: true).order(:display_order) }

  def picture_path
    "/images/#{picture}"
  end
end
