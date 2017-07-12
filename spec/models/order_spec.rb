require 'rails_helper'

RSpec.describe Order, type: :model do
  before :each do
    @user1 = FactoryGirl.create(:user, name: "user1")
    @user2 = FactoryGirl.create(:user, name: "user2")
    @user3 = FactoryGirl.create(:user, name: "user3")
    @p1 = FactoryGirl.create(:product, name: "p1", price: 100 )
    @p2 = FactoryGirl.create(:product, name: "p2", price: 200)
    @p3 = FactoryGirl.create(:product, name: "p3", price: 300, display_order: 3, is_visible: true)
  end

  describe '.new_from_user' do
    before :each do
      @cp13 = FactoryGirl.create(:cart_product, user: @user1, product: @p1, quantity: 3)
      @cp2  = FactoryGirl.create(:cart_product, user: @user2)
      @cp11 = FactoryGirl.create(:cart_product, user: @user1, product: @p2)
      @cp3  = FactoryGirl.create(:cart_product, user: @user3)
      @cp12 = FactoryGirl.create(:cart_product, user: @user1, product: @p3, quantity: 2)
    end

    example 'valid instance' do
      order = Order.new_from_user(@user1)
      expect(order.user).to eq @user1
      expect(order.order_products.length).to eq 3
      # expect(order.order_products.count).to eq 3    # dbに保存されていないので、countは0 ※countは必ずDB問い合わせ SELECT count(*) が走る

      expect(order.order_products[0].product).to eq @p3
      expect(order.order_products[1].product).to eq @p2
      expect(order.order_products[2].product).to eq @p1

      expect(order.order_products[0].quantity).to eq 2
      expect(order.order_products[1].quantity).to eq 1
      expect(order.order_products[2].quantity).to eq 3

      expect(order.total).to eq 100 * 3 + 200 + 300 * 2
    end
  end
  example "#total" do
    order1 = FactoryGirl.create(:order, user: @user1)
    op1 = FactoryGirl.create(:order_product, order: order1, product: @p1, quantity: 1)
    op2 = FactoryGirl.create(:order_product, order: order1, product: @p2, quantity: 2)

    expect(order1.total).to eq 500
  end
end
