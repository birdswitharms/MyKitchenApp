require 'test_helper'

class StepTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'a_step' do
    recipe = create(:recipe)
    step = create(:step, recipe: recipe)
    assert_equal( recipe, step.recipe )
  end
end
