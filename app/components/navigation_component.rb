# frozen_string_literal: true

class NavigationComponent < ViewComponent::Base
  attr_reader :group
  def initialize(group:)
    @group = group
  end

  def users
    group.users.order(:name)
  end

end
