# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_role?(:admin)
        @record.all
      else
        @record.where(id: user.id)
      end
    end
  end

  def index?
    user.has_role?(:admin)
  end

  def show?
    user.has_role?(:admin) || user == record
  end

  def create?
    user.has_role?(:admin)
  end

  def update?
    user.has_role?(:admin)
  end

  def destroy?
    user.has_role?(:admin)
  end
end
