require 'rails_helper'

RSpec.describe Product, type: :model do

  example 'default value' do
    product = FactoryGirl.create(:product)
    expect(product.name).to eq '商品1'
    expect(product.picture).to eq ''
    expect(product.price).to eq 99999999
    expect(product.description).to eq ''
    expect(product.is_visible).to eq false
    expect(product.display_order).to eq 0
  end
  example ".to_display" do
    p3 = FactoryGirl.create(:product, name: '3', display_order: 3, is_visible: true)
    p0 = FactoryGirl.create(:product, name: '0', display_order: 0, is_visible: true)
    p2 = FactoryGirl.create(:product, name: '2', display_order: 2, is_visible: false)

    products_all = Product.all
    expect(products_all.count).to eq 3

    products = Product.to_display.all
    expect(products.count).to eq 2

    expect(products[0].name).to eq p0.name
    expect(products[1].name).to eq p3.name
  end

  example '#picture_path' do
    product = FactoryGirl.build(:product)
    expect(product.picture_path).to eq ''

    product = FactoryGirl.build(:product, picture: "test.jpg")
    expect(product.picture_path).to eq "/images/test.jpg"

  end
end
