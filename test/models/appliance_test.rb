require 'test_helper'

class ApplianceTest < ActiveSupport::TestCase
  # test 'A category exists' do
  #   category = build(:category)
  #   assert( category )
  # end

  test "appliance and recipe are connected" do
    appliance = create(:appliance)
    assert(appliance)
  end
end
