FactoryGirl.define do
  factory :item do
    itemable_id { Faker::Number.number(1) }
    itemable_type { Faker::Lorem.characters(5) }
    product_id { Faker::Number.number(1) }
    quantity { Faker::Number.number(2) }
    association :itemable, factory: :cart
  end
end
