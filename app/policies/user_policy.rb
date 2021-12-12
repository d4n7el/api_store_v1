class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? 
  end

  def destroy?
    user.admin?
  end

  def update?
    user.admin? || record.id == user.id
  end

  def edit?
    user.admin? || record.id == user.id
  end
end
