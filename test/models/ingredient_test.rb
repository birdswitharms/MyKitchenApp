require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'An ingredient can be created' do
    ingredient = build(:ingredient, food: create(:food), measurement_unit: "1 tsp")
    assert ingredient.valid?
  end

  test 'An ingredient is invalid if food does not exist' do
    ingredient = build(:ingredient, food: nil, measurement_unit: "1 tsp")
    assert ingredient.invalid?
  end

  test 'An ingredient is invalid if measurement_unit does not exist' do
    ingredient = build(:ingredient, food: create(:food), measurement_unit: nil)
    assert ingredient.invalid?
  end

end
