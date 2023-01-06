# frozen_string_literal: true

class GroupUsersComponent < ViewComponent::Base

  attr_reader :group, :timing, :only_shared

  def initialize(group:, timing:, only_shared: true)
    @group = group
    @timing = timing&.to_sym || :this_month
    @only_shared = only_shared
  end

  private

  def users
    group.users.order(:name)
  end

  def transactions
    group.transactions.send(timing).send(only_shared ? :shared : :all)
  end

end
