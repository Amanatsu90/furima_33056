FactoryBot.define do
  factory :item do
    name             { Faker::Commerce.product_name }
    info             { Faker::Lorem.sentence }
    price            { Faker::Commerce.price(range: 300..1000.0, as_string: true) }
    association :user
    association :category
    association :condition
    association :delivery_fee
    association :prefecture
    association :delivery_time

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/sample1.png'), filename: 'sample1.png')
    end
  end
end
