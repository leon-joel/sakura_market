FactoryGirl.define do
  factory :order do
    user nil
    order_datetime "2017-06-25 10:20:30"
    send_to "MyString"
    date_to_deliver "2017-06-25"
    time_range_to_deliver "MyString"
  end
end
