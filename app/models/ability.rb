# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    can :manage, :all if user.has_role? :admin
  end
end
