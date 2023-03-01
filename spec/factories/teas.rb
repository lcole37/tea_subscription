FactoryBot.define do
  factory :tea do
    title { Faker::Tea.type }
    description { Faker::Food.description }
    temperature { Faker::Number.within(range: 165..200) }
    brew_time { Faker::Number.within(range: 2..6) }
  end
end
