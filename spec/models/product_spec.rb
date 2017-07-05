require 'rails_helper'

RSpec.describe Product, type: :model do

  example '#picture_path' do
    product = FactoryGirl.build(:product)
    expect(product.picture_path).to eq '/images/tomato.jpg'

  end
end
