FactoryBot.define do
  factory :delivery_time do
    id {Faker::Number.between(from: 2, to: 4)}
  end
end
