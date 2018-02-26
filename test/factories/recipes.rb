FactoryBot.define do
  factory :recipe do
    sequence(:name )    { |num| "Recipe #{num}"}
    user
  end
end
