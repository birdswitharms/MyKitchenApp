require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def test_example_dot_com
     VCR.use_cassette("avocado21") do
     response = Recipe.requestapi('avocado')
     assert_equal(["meals"], response.keys)
     end
  end

  test 'A recipe can be created' do
    recipe = build(:recipe, user: create(:user))
    recipe.steps.new(content: "ayyy")
    recipe.ingredients.new(food: create(:food), measurement_unit: "1 teaspoon")
    recipe.save
    assert recipe.valid?
  end

  test 'A recipe cannot be created without user' do
    recipe = build(:recipe)
    recipe.steps.new(content: "ayyy")
    recipe.ingredients.new(food: create(:food), measurement_unit: "1 teaspoon")
    recipe.save
    assert recipe.invalid?
  end

  test 'A recipe cannot be created without atleast 1 step' do
    recipe = build(:recipe, user: create(:user))
    recipe.ingredients.new(food: create(:food), measurement_unit: "1 teaspoon")
    recipe.save
    assert recipe.invalid?
  end

  test 'A recipe cannot be created without atleast 1 ingredient' do
    recipe = build(:recipe, user: create(:user))
    recipe.steps.new(content: "ayyy")
    recipe.save
    assert recipe.invalid?
  end




end
