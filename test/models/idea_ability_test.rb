require "test_helper"

class IdeaAbilityTest < ActiveSupport::TestCase
  test "anonymous user permissions on ideas" do
    user    = nil
    idea    = create_idea
    ability = Ability.new(user)
    assert ability.can?(:read, idea)
    assert ability.cannot?(:create, Idea.new(user: user))
    assert ability.cannot?(:destroy, idea)
    assert ability.cannot?(:update, idea)
  end

  test "non-twitch user permissions on ideas" do
    user    = User.create!
    idea    = create_idea
    ability = Ability.new(user)
    assert ability.can?(:read, idea)
    assert ability.cannot?(:create, Idea.new(user: user))
    assert ability.cannot?(:destroy, idea)
    assert ability.cannot?(:update, idea)
  end

  test "newbie twitch user ideas permissions" do
    user    = create_twitch_user(since: Date.yesterday)
    idea    = Idea.new(user: user)
    ability = Ability.new(user)
    assert ability.cannot?(:create, idea)
    assert ability.cannot?(:destroy, idea)
    assert ability.cannot?(:update, idea)
  end

  test "old time twitch user ideas permissions" do
    user    = create_twitch_user(since: 1.month.ago)
    idea    = Idea.new(user: user)
    ability = Ability.new(user)
    assert ability.can?(:create, idea)
    assert ability.can?(:destroy, idea)
    assert ability.can?(:update, idea)
  end
end
