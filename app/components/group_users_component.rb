# frozen_string_literal: true

class GroupUsersComponent < ViewComponent::Base

  attr_reader :group, :scope, :only_shared

  def initialize(group:, scope: :this_month, only_shared: true)
    @group = group
    @scope = scope
    @only_shared = only_shared
  end

  private

  def users
    group.users.order(:name)
  end

  def transactions
    group.transactions.send(scope).send(only_shared ? :shared : :all)
  end

end
