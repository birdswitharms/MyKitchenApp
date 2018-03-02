require 'test_helper'

class StepTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'A step is valid' do
    step = build(:step)
    assert step.invalid?
  end

  test 'A step cannot be created without a message/content' do
    step = build(:step, content: nil)
    assert step.invalid?
  end

end
