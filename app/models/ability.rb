# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, [Idea, Star]

    return unless user.twitch_id? && user.twitch_old_timer?

    can :manage, [Idea, Star], user: user
  end
end
