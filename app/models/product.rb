class Product < ApplicationRecord
  scope :to_display, -> { where(is_visible: true).order(:display_order) }
end
