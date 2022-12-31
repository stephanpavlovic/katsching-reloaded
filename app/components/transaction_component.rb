# frozen_string_literal: true

class TransactionComponent < ViewComponent::Base

  attr_reader :transaction

  def initialize(transaction:)
    @transaction = transaction
  end

  private

  def user
    transaction.user
  end

  def amount
    helpers.format_money transaction.amount.abs
  end

  def relevant_date
    transaction.date.presence || transaction.created_at
  end

end
