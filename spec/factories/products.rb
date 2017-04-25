FactoryGirl.define do
  factory :product do |f|
    f.name { Faker::Name.unique.name }
    f.description { Faker::Lorem.characters(100) }
    f.price { Faker::Number.number(3) }
    f.quantity { Faker::Number.number(2) }
    f.maker { Faker::Name.unique.name }
  end
end
