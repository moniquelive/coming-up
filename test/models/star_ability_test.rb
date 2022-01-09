require "test_helper"

class StarAbilityTest < ActiveSupport::TestCase
  test "anonymous user permissions on stars" do
    user    = nil
    idea    = create_idea
    star    = idea.stars.first
    ability = Ability.new(user)
    assert ability.cannot?(:create, Star.new(idea: idea, user: user))
    assert ability.can?(:read, star)
    assert ability.cannot?(:destroy, star)
    assert ability.cannot?(:update, star)
  end

  test "non-twitch user permissions on stars" do
    user    = User.create!
    idea    = create_idea
    star    = idea.stars.first
    ability = Ability.new(user)
    assert ability.cannot?(:create, Star.new(idea: idea, user: user))
    assert ability.can?(:read, star)
    assert ability.cannot?(:destroy, star)
    assert ability.cannot?(:update, star)
  end

  test "newbie twitch user permissions on stars" do
    newbie  = create_twitch_user(since: Date.yesterday)
    idea    = create_idea
    star    = idea.stars.first
    ability = Ability.new(newbie)
    assert ability.cannot?(:create, Star.new(idea: idea, user: newbie))
    assert ability.can?(:read, star)
    assert ability.cannot?(:destroy, star)
    assert ability.cannot?(:update, star)
  end

  test "old time twitch user permissions on stars" do
    user    = create_twitch_user(since: 1.month.ago)
    idea    = Idea.create!(user: user)
    star    = idea.stars.first
    ability = Ability.new(user)
    assert ability.can?(:create, Star.new(idea: idea, user: user))
    assert ability.can?(:read, star)
    assert ability.can?(:destroy, star)
    assert ability.can?(:update, star)
  end
end
