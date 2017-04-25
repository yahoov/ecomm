FactoryGirl.define do
  factory :cart do |f|
    f.user_id { Faker::Number.number(1) }
    f.association :user
  end
end
