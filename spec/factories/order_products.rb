FactoryGirl.define do
  factory :order_product do
    order
    product
    sales_price 1
    quantity 1
  end
end
