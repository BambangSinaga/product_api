FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    price { Faker::Number.number(digits: 3) }
    email { Faker::Internet.email }
    category { 'Desert' }
  end
end