FactoryBot.define do
  factory :user do
    name                  'Test'
    sequence(:email)      {|num| "test#{num}@test.com"}
    password              '1234'
    password_confirmation '1234'
  end
end
