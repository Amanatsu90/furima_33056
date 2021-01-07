FactoryBot.define do
  factory :condition do
    id {Faker::Number.between(from: 2, to: 7)}
  end
end
