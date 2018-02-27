FactoryBot.define do
  factory :step do
    sequence(:content ) { |num| "Step #{num}"}
    # recipe              {Recipe.all.sample}
  end
end
