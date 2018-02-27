FactoryBot.define do
  factory :food do
    sequence(:name) { |num| "Food #{num}" }
  end
end
