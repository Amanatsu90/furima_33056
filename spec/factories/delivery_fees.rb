FactoryBot.define do
  factory :delivery_fee do
    id { Faker::Number.between(from: 2, to: 3) }
  end
end
