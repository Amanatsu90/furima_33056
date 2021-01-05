FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    last_name             { 'スズキ' }
    first_name            { 'ハナコ' }
    kana_last             { 'スズキ' }
    kana_first            { 'ハナコ' }
    birth                 { '1930-1-1' }
    email                 { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
  end
end
