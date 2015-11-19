class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    show?
  end

  def create?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def show?
    record.private? == false || ((record.private? == true && record.user == user) || user.admin?) || record.users.include?(user)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private? == false || wiki.user == user || wiki.users.include?(user)
            wikis << wiki
          end
        end
      elsif
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private? == false || wiki.users.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
