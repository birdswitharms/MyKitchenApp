FactoryBot.define do
  factory :review do
    sequence(:comment) { |num| "Recipe review! #{num}/100"}
  end
end
