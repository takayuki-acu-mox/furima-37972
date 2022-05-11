FactoryBot.define do
  factory :item do
    image         {Faker::Lorem.sentence}
    item_name     {Faker::Lorem.sentence}
    text          {Faker::Lorem.sentence}
    association :user
    product_condition_id  {2}
    shipping_fee_id       {2}
    shipment_area_id      {2}
    shipping_date_id      {2}
    category_id           {2}
    price                 {2000}
  end
end
