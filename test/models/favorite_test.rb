require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'A favorite can be created' do
    recipe = build(:recipe, user: create(:user))
    recipe.steps.new(content: "ayyy")
    recipe.ingredients.new(food: create(:food), measurement_unit: "1 teaspoon")
    recipe.save
    favorite = build(:favorite, user: create(:user), recipe: recipe)
    assert favorite.valid?
  end

  test 'A favorite is invalid if recipe is not provided' do
    favorite = build(:favorite, user: create(:user), recipe: nil)
    assert favorite.invalid?
  end

  test 'A favorite is invalid if user is not provided' do
    recipe = build(:recipe, user: create(:user))
    recipe.steps.new(content: "ayyy")
    recipe.ingredients.new(food: create(:food), measurement_unit: "1 teaspoon")
    recipe.save
    favorite = build(:favorite, user: nil, recipe: recipe)
    assert favorite.invalid?
  end


end
