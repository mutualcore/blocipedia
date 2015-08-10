class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show? 
    !record.private? || user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.admin?
        wikis = scope.all
      elsif user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private?
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end