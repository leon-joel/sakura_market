FactoryGirl.define do
  factory :order do
    user
    send_to_name "山田 太郎"
    send_to_address "東京都台東区三ノ輪1-2-3"
  end
end
