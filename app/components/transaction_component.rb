# frozen_string_literal: true

class TransactionComponent < ViewComponent::Base

  attr_reader :transaction

  def initialize(transaction:, highlight: false)
    @transaction = transaction
    @highlight = highlight
  end

  private

  def classes
    classes = @highlight ? ['FlashEffectGrey'] : []
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
