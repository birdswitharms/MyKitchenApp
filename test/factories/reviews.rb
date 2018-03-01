FactoryBot.define do
  factory :review do
    recipe              {Recipe.all.sample}
    user
    sequence(:comment ) { |num| "Recipe review! #{num}/100"} 
  end
end
