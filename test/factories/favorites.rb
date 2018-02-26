FactoryBot.define do
  factory :favorites do
    sequence(:name )    { |num| "Appliance #{num}"}
  end
end
