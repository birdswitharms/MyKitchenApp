FactoryBot.define do
  factory :step do
    sequence(:content) { |num| "Step #{num}"}
  end
end
