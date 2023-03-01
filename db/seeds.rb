require 'faker'

10.times do
  Tea.create(
    title: Faker::Tea.type,
    description: Faker::Food.description,
    temperature: Faker::Number.within(range: 165..200),
    brew_time: Faker::Number.within(range: 2..6)
  )
end

3.times do
  Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.free_email,
    address: Faker::Address.full_address,
  )
end

Subscription.create(
  title: "#{Customer.first.first_name} #{Customer.first.last_name}'s #{Tea.first.title}",
  price: Faker::Number.within(range: 3..20),
  status: [0, 1].sample,
  frequency: [0, 1, 2, 3].sample,
  tea_id: Tea.first.id,
  customer_id: Customer.first.id
)

Subscription.create(
  title: "#{Customer.first.first_name} #{Customer.first.last_name}'s #{Tea.second.title}",
  price: Faker::Number.within(range: 3..20),
  status: [0, 1].sample,
  frequency: [0, 1, 2, 3].sample,
  tea_id: Tea.second.id,
  customer_id: Customer.first.id
)

Subscription.create(
  title: "#{Customer.second.first_name} #{Customer.second.last_name}'s #{Tea.third.title}",
  price: Faker::Number.within(range: 3..20),
  status: [0, 1].sample,
  frequency: [0, 1, 2, 3].sample,
  tea_id: Tea.third.id,
  customer_id: Customer.first.id
)
