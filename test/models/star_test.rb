require "test_helper"

class StarTest < ActiveSupport::TestCase
  test "invalid" do
    assert_not Star.new.save
    assert_not Star.new(user: User.new).save
    assert_not Star.new(idea: Idea.new).save
  end

  test "valid" do
    user = User.new
    idea = Idea.new(user: user)
    assert_equal true, Star.new(user: user, idea: idea).save
  end
end
