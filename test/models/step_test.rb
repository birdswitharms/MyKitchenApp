require 'test_helper'

class StepTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'A step is valid' do
    step = build(:step)
    assert step.invalid?
  end

  test 'A step is invalid' do
    step = build(:step, content: nil)
    assert step.invalid?
  end

end
