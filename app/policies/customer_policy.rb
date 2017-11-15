class CustomerPolicy < ApplicationPolicy
  def destroy?
    false
  end
end
