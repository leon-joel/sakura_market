require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  before :each do
    @user1 = FactoryGirl.create(:user, name: "user1")
    @user2 = FactoryGirl.create(:user, name: "user2")
    @user3 = FactoryGirl.create(:user, name: "user3")
    @p1 = FactoryGirl.create(:product, name: "p1", display_order: 1, is_visible: true)
    @p2 = FactoryGirl.create(:product, name: "p2", display_order: 2, is_visible: false)
    @p3 = FactoryGirl.create(:product, name: "p3", display_order: 3, is_visible: true)
    @p4 = FactoryGirl.create(:product, name: "p4", display_order: 4, is_visible: true)
  end

  example 'default value' do
    cart_product = FactoryGirl.create :cart_product
    expect(cart_product.quantity).to eq 1
    expect(cart_product.user.name).to eq "test_user1"
    expect(cart_product.product.name).to eq "商品1"
  end

end
