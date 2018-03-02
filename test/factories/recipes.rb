FactoryBot.define do
  factory :recipe do
    sequence(:name)    { |num| "Recipe #{num}"}
    sequence(:steps)    { |num| "Step #{num}"}
    sequence(:ingredients)    { |num| "Ingredient #{num}"}
  end
end
