FactoryBot.define do
  factory :appliance do
    sequence(:name )    { |num| "Appliance #{num}"}
  end
end
