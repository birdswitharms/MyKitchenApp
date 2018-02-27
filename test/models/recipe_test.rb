require 'test_helper'


class RecipeTest < ActiveSupport::TestCase

  def test_example_dot_com
    VCR.use_cassette("synopsis2") do
    response = Recipe.requestapi
    assert_equal(["meals"], response.keys)
  end

end
  # test "the truth" do
  #   assert true
  # end
  # def setup
  #
  # end

  # test 'asd' do
  #   skip
  # end
end
