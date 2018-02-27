FactoryBot.define do
  factory :ingredient do
    food
    sequence(:measurement_unit )  { |num| "#{num} grams"}
    calories            (1..100).to_a.sample
    total_fat           (1..100).to_a.sample
    saturated_fat       (1..100).to_a.sample
    cholesterol         (1..100).to_a.sample
    sodium              (1..100).to_a.sample
    potassium           (1..100).to_a.sample
    total_carbohydrates (1..100).to_a.sample
    dietary_fiber       (1..100).to_a.sample
    sugars              (1..100).to_a.sample
    protein             (1..100).to_a.sample
  end
end
