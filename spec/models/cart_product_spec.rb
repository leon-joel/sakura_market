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

  describe "class methods" do
    before :each do
      @cp13 = FactoryGirl.create(:cart_product, user: @user1, product: @p1, quantity: 3)
      @cp2  = FactoryGirl.create(:cart_product, user: @user2)
      @cp11 = FactoryGirl.create(:cart_product, user: @user1, product: @p2)
      @cp3  = FactoryGirl.create(:cart_product, user: @user3)
      @cp12 = FactoryGirl.create(:cart_product, user: @user1, product: @p3, quantity: 2)
    end

    example '.of_user' do
      cart_products = CartProduct.of_user(@user1)
      expect(cart_products.count).to eq 3
      expect(cart_products[0].user).to eq @user1
      expect(cart_products[0].product).to eq @p3
      expect(cart_products[0].quantity).to eq 2
      expect(cart_products[1].user).to eq @user1
      expect(cart_products[1].product).to eq @p2
      expect(cart_products[1].quantity).to eq 1
      expect(cart_products[2].user).to eq @user1
      expect(cart_products[2].product).to eq @p1
      expect(cart_products[2].quantity).to eq 3
    end

    example '.insert_or_increment' do
      expect {
        # increment
        result, cp = CartProduct.insert_or_increment(@user1, @p1)
        expect(result).to be_truthy
        expect(cp.user).to eq @user1
        expect(cp.product).to eq @p1
        expect(cp.quantity).to eq 4
      }.not_to change {CartProduct.of_user(@user1).count}   # 変化しないこと

      expect {
        # insert
        result, cp = CartProduct.insert_or_increment(@user1, @p4)
        expect(result).to be_truthy
        expect(cp.user).to eq @user1
        expect(cp.product).to eq @p4
        expect(cp.quantity).to eq 1
      }.to change {CartProduct.of_user(@user1).count}.by(1)   # 1増えること
    end
  end
end
