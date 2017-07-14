require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  before :each do
    @user1 = FactoryGirl.create(:user, name: "user1")
    @user2 = FactoryGirl.create(:user, name: "user2")
    @user3 = FactoryGirl.create(:user, name: "user3")
    @p1 = FactoryGirl.create(:product, name: "p1", price: 100 )
    @p2 = FactoryGirl.create(:product, name: "p2", price: 200)
    @p3 = FactoryGirl.create(:product, name: "p3", display_order: 3, is_visible: true)
    @p4 = FactoryGirl.create(:product, name: "p4", display_order: 4, is_visible: true)
  end

  example '#subtotal' do
    order1 = FactoryGirl.build(:order, user: @user1)
    order1.order_products << FactoryGirl.build(:order_product, order: order1, product: @p1, quantity: 1)
    order1.order_products << FactoryGirl.build(:order_product, order: order1, product: @p2, quantity: 2)

    expect(order1.order_products[0].subtotal).to eq 100
    expect(order1.order_products[1].subtotal).to eq 400
  end
end
