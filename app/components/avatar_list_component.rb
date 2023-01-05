# frozen_string_literal: true

class AvatarListComponent < ViewComponent::Base

  def initialize(transaction:)
    @transaction = transaction
  end

  private

  def avatars
    users = [@transaction.user]
    if @transaction.shared?
      missing = @transaction.group.users - users
      users += missing
    end
    users
  end

end
