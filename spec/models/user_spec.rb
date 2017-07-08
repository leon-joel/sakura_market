require 'rails_helper'

RSpec.describe User, type: :model do
  describe "default value" do
    it 'must have certain values' do
      expect(User.new.save).to be_falsey
      expect(User.new(name: 'user1').save).to be_falsey
      expect(User.new(email: 'user1@example.com').save).to be_falsey

      user = User.new(name: 'user1', email: 'user1@example.com', password: '')
      expect(user.save).to be_truthy

      expect(user.name).to eq 'user1'
      expect(user.password_digest).to be_present
      expect(user.address).to eq ''
    end
  end

  describe "relations" do
    before :each do
      # TODO: cart_product_spec.rbにも同じセットがあるんだけど、これどうやって共有するんだろ??? むしろDRYじゃない方がいいのか???
      @user1 = FactoryGirl.create(:user, name: "user1")
      @user2 = FactoryGirl.create(:user, name: "user2")
      @user3 = FactoryGirl.create(:user, name: "user3")
      @p1 = FactoryGirl.create(:product, name: "p1", display_order: 1, is_visible: true)
      @p2 = FactoryGirl.create(:product, name: "p2", display_order: 2, is_visible: false)
      @p3 = FactoryGirl.create(:product, name: "p3", display_order: 3, is_visible: true)
      @p4 = FactoryGirl.create(:product, name: "p4", display_order: 4, is_visible: true)

    end

    describe "#cart_products" do
      before :each do
        @cp13 = FactoryGirl.create(:cart_product, user: @user1, product: @p1, quantity: 3)
        @cp2  = FactoryGirl.create(:cart_product, user: @user2)
        @cp11 = FactoryGirl.create(:cart_product, user: @user1, product: @p2)
        @cp3  = FactoryGirl.create(:cart_product, user: @user3)
        @cp12 = FactoryGirl.create(:cart_product, user: @user1, product: @p3, quantity: 2)
      end

      example "cart_products" do
        cart_products = @user1.cart_products
        expect(cart_products.count).to eq 3

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
    end

  end
  describe "#password=" do
    example "文字列を与えると、password_digest は長さ60の文字列になる" do
      user = User.new
      user.password = 'abc'
      expect(user.password_digest).to be_kind_of(String)
      expect(user.password_digest.size).to eq 60
    end

    example 'nilを与えると、password_digest もnilになる' do
      user = User.new(password_digest: 'x')
      user.password = nil
      expect(user.password_digest).to be_nil
    end

    example 'string以外を与えると, password_digestは変化しない' do
      user = User.new(password_digest: 'x')
      user.password = 1
      expect(user.password_digest).to eq 'x'
    end
  end
end
