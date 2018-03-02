require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'A review is valid' do
    user = create(:user)
    recipe = build(:recipe, user: user)
    recipe.steps.new(content: "ayyy")
    recipe.ingredients.new(food: create(:food), measurement_unit: "1 teaspoon")
    recipe.save
    review = build(:review, user: create(:user), recipe: recipe)
    assert review.valid?
  end

  test 'A review is invalid if no message is made' do
    user = create(:user)
    recipe = build(:recipe, user: user)
    recipe.steps.new(content: "ayyy")
    recipe.ingredients.new(food: create(:food), measurement_unit: "1 teaspoon")
    recipe.save
    review = build(:review, comment: nil, user: create(:user), recipe: recipe)
    assert review.invalid?
  end

end
