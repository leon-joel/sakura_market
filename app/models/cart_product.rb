class CartProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def self.of_user(user)
    where(user_id: user.id).order(created_at: :desc)
  end
end
