require "test_helper"

class IdeaAbilityTest < ActiveSupport::TestCase
  test "anonymous user permissions on ideas" do
    idea    = create_idea
    ability = Ability.new(nil)
    assert ability.can?(:read, idea)
    assert ability.cannot?(:create, Idea.new(user: nil))
    assert ability.cannot?(:destroy, idea)
    assert ability.cannot?(:update, idea)
  end

  test "non-twitch user permissions on ideas" do
    idea    = create_idea
    user    = User.create!
    ability = Ability.new(user)
    assert ability.can?(:read, idea)
    assert ability.cannot?(:create, Idea.new(user: user))
    assert ability.cannot?(:destroy, idea)
    assert ability.cannot?(:update, idea)
  end

  test "newbie twitch user ideas permissions" do
    user    = create_twitch_user(1.month.ago + 1)
    idea    = Idea.new(user: user)
    ability = Ability.new(user)
    assert ability.cannot?(:create, idea)
    assert ability.cannot?(:destroy, idea)
    assert ability.cannot?(:update, idea)
  end

  test "old time twitch user ideas permissions" do
    user    = create_twitch_user(1.month.ago)
    idea    = Idea.new(user: user)
    ability = Ability.new(user)
    assert ability.can?(:create, idea)
    assert ability.can?(:destroy, idea)
    assert ability.can?(:update, idea)
  end
end
