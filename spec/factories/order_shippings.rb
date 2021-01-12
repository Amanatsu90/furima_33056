FactoryBot.define do
  factory :order_shipping do
    postal_code   { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { '千代田区' }
    addresses     { '1-1' }
    phone_number  { '09012345678' }
  end
end
