FactoryBot.define do
  factory :item do
    item_name     {Faker::Lorem.sentence}
    text          {Faker::Lorem.sentence}
    association :user
    product_condition_id  {2}
    shipping_fee_id       {2}
    shipment_area_id      {2}
    shipping_date_id      {2}
    category_id           {2}
    price                 {2000}

    after(:build) do |item|
    item.image.attach(io: File.open('app/assets/images/star.png'), filename: 'star.png')
  end
end
end
