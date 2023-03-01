FactoryBot.define do
  factory :subscription do
    title { "#{customer.first_name} #{customer.last_name}'s #{tea.title}" }
    price { Faker::Number.within(range: 3..20) }
    status { [0, 1].sample }
    frequency { [0, 1, 2, 3].sample }
    tea { create(:tea) }
    customer { create(:customer) }
  end
end
