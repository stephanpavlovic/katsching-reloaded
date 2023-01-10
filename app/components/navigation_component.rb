# frozen_string_literal: true

class NavigationComponent < ViewComponent::Base
  def initialize
  end

  def group
    helpers.current_user.group
  end

  def users
    group.users.order(:name)
  end

end
