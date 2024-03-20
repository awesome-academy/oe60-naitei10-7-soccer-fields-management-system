# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :manage, [Booking, Field, FieldType, FavoriteFieldType]
    elsif user.user?
      can :read, [Field, FieldType, Booking]
      can :read, Booking, user_id: user.id
      can %i[create destroy], Booking
      can :create, FavoriteFieldType
      can :update, User, id: user.id
    else
      can :read, [Field, FieldType]
    end
  end
end
