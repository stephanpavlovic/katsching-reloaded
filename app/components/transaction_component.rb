# frozen_string_literal: true

class TransactionComponent < ViewComponent::Base

  attr_reader :transaction

  def initialize(transaction:)
    @transaction = transaction
  end

  private

  def amount
    helpers.format_money transaction.amount.abs
  end

  def relevant_date
    transaction.date.presence || transaction.created_at
  end

  def incoming?
    transaction.amount.positive?
  end

  def outgoing?
    !transaction.amount.positive?
  end

end
