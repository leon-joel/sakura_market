require 'rails_helper'

RSpec.describe Order, type: :model do
  before :each do
    @user1 = FactoryGirl.create(:user, name: "user1")
    @user2 = FactoryGirl.create(:user, name: "user2")
    @user3 = FactoryGirl.create(:user, name: "user3")
    @p1 = FactoryGirl.create(:product, name: "p1", price: 100 )
    @p2 = FactoryGirl.create(:product, name: "p2", price: 200)
    @p3 = FactoryGirl.create(:product, name: "p3", display_order: 3, is_visible: true)
    @p4 = FactoryGirl.create(:product, name: "p4", display_order: 4, is_visible: true)
  end

  example "#total" do
    order1 = FactoryGirl.create(:order, user: @user1)
    op1 = FactoryGirl.create(:order_product, order: order1, product: @p1, quantity: 1)
    op2 = FactoryGirl.create(:order_product, order: order1, product: @p2, quantity: 2)

    expect(order1.total).to eq 500
  end
end
