require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def test_example_dot_com
     VCR.use_cassette("avocado21") do
     response = Recipe.requestapi('avocado')
     assert_equal(["meals"], response.keys)
     end
  end

  test 'A recipe can be created' do
    recipe = build(:recipe)
    assert recipe.valid?
  end





end
