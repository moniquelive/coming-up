require "test_helper"

class StarAbilityTest < ActiveSupport::TestCase
  test "anonymous user permissions on stars" do
    idea    = create_idea
    star    = idea.stars.first
    ability = Ability.new(nil)
    assert ability.cannot?(:create, Star.new(idea: idea, user: nil))
    assert ability.can?(:read, star)
    assert ability.cannot?(:destroy, star)
    assert ability.cannot?(:update, star)
  end

  test "non-twitch user permissions on stars" do
    idea    = create_idea
    user    = User.create!
    star    = idea.stars.first
    ability = Ability.new(user)
    assert ability.cannot?(:create, Star.new(idea: idea, user: user))
    assert ability.can?(:read, star)
    assert ability.cannot?(:destroy, star)
    assert ability.cannot?(:update, star)
  end

  test "newbie twitch user permissions on stars" do
    idea    = create_idea
    newbie  = create_twitch_user(1.month.ago + 1)
    star    = idea.stars.first
    ability = Ability.new(newbie)
    assert ability.cannot?(:create, Star.new(idea: idea, user: newbie))
    assert ability.can?(:read, star)
    assert ability.cannot?(:destroy, star)
    assert ability.cannot?(:update, star)
  end

  test "old time twitch user permissions on stars" do
    user    = create_twitch_user(1.month.ago)
    idea    = Idea.create!(user: user)
    star    = idea.stars.first
    ability = Ability.new(user)
    assert ability.can?(:create, Star.new(idea: idea, user: user))
    assert ability.can?(:read, star)
    assert ability.can?(:destroy, star)
    assert ability.can?(:update, star)
  end
end
