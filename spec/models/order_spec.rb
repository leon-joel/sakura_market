require 'rails_helper'

RSpec.describe Order, type: :model do
  example '#calc_postage' do
    expect(Order.calc_postage(0)).to eq 0
    expect(Order.calc_postage(1)).to eq 600
    expect(Order.calc_postage(5)).to eq 600
    expect(Order.calc_postage(6)).to eq 1200
    expect(Order.calc_postage(10)).to eq 1200
    expect(Order.calc_postage(11)).to eq 1800
  end
  example '#calc_cod_fee' do
    expect(Order.calc_cod_fee(0)).to eq 0
    expect(Order.calc_cod_fee(9999)).to eq 300
    expect(Order.calc_cod_fee(10000)).to eq 400
    expect(Order.calc_cod_fee(29999)).to eq 400
    expect(Order.calc_cod_fee(30000)).to eq 600
    expect(Order.calc_cod_fee(99999)).to eq 600
    expect(Order.calc_cod_fee(100000)).to eq 1000
    expect(Order.calc_cod_fee(1000000)).to eq 1000
  end
  example '#calc_tax' do
    expect(Order.calc_tax(0)).to eq 0
    expect(Order.calc_tax(12)).to eq 0
    expect(Order.calc_tax(13)).to eq 1
    expect(Order.calc_tax(99)).to eq 7
    expect(Order.calc_tax(100)).to eq 8
    expect(Order.calc_tax(112)).to eq 8
    expect(Order.calc_tax(113)).to eq 9
  end

  describe "factory methods" do
    before :each do
      @user1 = FactoryGirl.create(:user, name: "user1")
      @user2 = FactoryGirl.create(:user, name: "user2")
      @user3 = FactoryGirl.create(:user, name: "user3")

      @p1 = FactoryGirl.create(:product, name: "p1", price: 100 )
      @p2 = FactoryGirl.create(:product, name: "p2", price: 1000)
      @p3 = FactoryGirl.create(:product, name: "p3", price: 10000, display_order: 3, is_visible: true)

      @cp13 = FactoryGirl.create(:cart_product, user: @user1, product: @p1, quantity: 3)
      @cp2  = FactoryGirl.create(:cart_product, user: @user2)
      @cp11 = FactoryGirl.create(:cart_product, user: @user1, product: @p2)
      @cp3  = FactoryGirl.create(:cart_product, user: @user3)
      @cp12 = FactoryGirl.create(:cart_product, user: @user1, product: @p3, quantity: 2)
    end

    example '.new_from_cart' do
      order = Order.new_from_cart(@user1)
      expect(order.user).to eq @user1
      expect(order.order_products.length).to eq 3
      # expect(order.order_products.count).to eq 3    # dbに保存されていないので、countは0 ※countは必ずDB問い合わせ SELECT count(*) が走る

      expect(order.order_products[0].order).to eq order
      expect(order.order_products[1].order).to eq order
      expect(order.order_products[2].order).to eq order

      expect(order.order_products[0].product).to eq @p3
      expect(order.order_products[1].product).to eq @p2
      expect(order.order_products[2].product).to eq @p1

      expect(order.order_products[0].quantity).to eq 2
      expect(order.order_products[1].quantity).to eq 1
      expect(order.order_products[2].quantity).to eq 3

      expect(order.products_total).to eq 100 * 3 + 1000 + 10000 * 2
    end
  end

  describe "instance methods" do
    let(:user1) { FactoryGirl.build(:user, name: "user1") }
    let(:p1) { FactoryGirl.build(:product, name: "p1", price: 100 ) }
    let(:p2) { FactoryGirl.build(:product, name: "p2", price: 1000 ) }
    let(:p3) { FactoryGirl.build(:product, name: "p3", price: 10000 ) }

    let(:order0) { FactoryGirl.build(:order, user: user1) }
    let(:order1) {
      order = FactoryGirl.build(:order, user: user1)
      order.order_products << FactoryGirl.build(:order_product, order: order, product: p1, quantity: 1)
      order.order_products << FactoryGirl.build(:order_product, order: order, product: p2, quantity: 2)
      order
    }
    let(:order2) {
      order = FactoryGirl.build(:order, user: user1)
      order.order_products << FactoryGirl.build(:order_product, order: order, product: p1, quantity: 1)
      order.order_products << FactoryGirl.build(:order_product, order: order, product: p2, quantity: 2)
      order.order_products << FactoryGirl.build(:order_product, order: order, product: p3, quantity: 3)
      order
    }
    example "order0" do
      expect(order0.total_quantity).to eq 0
      expect(order0.products_total).to eq 0
      expect(order0.postage).to eq 0
      expect(order0.cod_fee).to eq 0
      expect(order0.tax).to eq 0
      expect(order0.grand_total).to eq 0
    end
    example "order1" do
      expect(order1.total_quantity).to eq 3
      expect(order1.products_total).to eq 2100
      expect(order1.postage).to eq 600
      expect(order1.cod_fee).to eq 300
      expect(order1.tax).to eq 240
      expect(order1.grand_total).to eq 3240
    end
    example "order2" do
      expect(order2.total_quantity).to eq 6
      expect(order2.products_total).to eq 32100
      expect(order2.postage).to eq 1200
      expect(order2.cod_fee).to eq 600
      expect(order2.tax).to eq 2712
      expect(order2.grand_total).to eq 36612
    end
  end
end
