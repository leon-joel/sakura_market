FactoryGirl.define do
  factory :product do
    name "リコピンたっぷり新鮮トマト"
    picture "tomato.jpg"
    price 456
    description "ザ・新鮮!!! ジューシーで濃厚!!! 新鮮トマト嫌いなお子様にも是非一度食べさせてあげてください。"
    is_visible true
    display_order 1
  end
end
