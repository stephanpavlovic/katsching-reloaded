# frozen_string_literal: true

class TransactionComponent < ViewComponent::Base

  attr_reader :transaction

  def initialize(transaction:)
    @transaction = transaction
  end

  private

  def classes
    classes = []
    classes << 'asFuture' if transaction.future?
    classes << 'asOutgoing' if transaction.outgoing?
    classes
  end

  def user
    transaction.user
  end

  def amount
    transaction.amount
  end

  def relevant_date
    transaction.date.presence || transaction.created_at
  end

end
