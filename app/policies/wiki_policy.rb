class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    user.present?
  end

  def create?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def show?
    record.private? == false || ((record.private? == true && record.user == user) || user.premium? || user.admin?)
  end
end
