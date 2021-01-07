FactoryBot.define do
  factory :category do
    id {Faker::Number.between(from: 2, to: 11)}
  end
end
