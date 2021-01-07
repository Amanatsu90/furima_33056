FactoryBot.define do
  factory :prefecture do
    id {Faker::Number.between(from: 2, to: 48)}
  end
end
