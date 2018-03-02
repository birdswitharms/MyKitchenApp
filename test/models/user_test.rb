require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'A user is able to be created' do
    user = create(:user)
    assert user.valid?
  end

  test 'A user must have email' do
    user = build(:user, email: nil)
    assert user.invalid?
  end

  test 'A user must have a name' do
    user = build(:user, name: nil)
    assert user.invalid?
  end

end
