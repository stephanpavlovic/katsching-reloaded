# frozen_string_literal: true

class TransactionListComponent < ViewComponent::Base

  attr_reader :transactions
  def initialize(transactions:)
    @transactions = transactions
  end

end
