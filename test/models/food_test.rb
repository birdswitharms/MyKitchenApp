require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'A food can be created' do
    food = build(:food, name: 'food name')
    assert food.valid?
  end

  test 'A food is invalid if name is not provided' do
    food = build(:food, name: nil)
    assert food.invalid?
  end

end
