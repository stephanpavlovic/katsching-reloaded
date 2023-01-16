module Streaming
  extend ActiveSupport::Concern

  def stream_transaction_destroy
    broadcast_remove_to "group_#{group.id}", target: "transaction_#{id}"
  end

  def stream_transaction_create
    broadcast_create(self, false)
    broadcast_create(self, true) if shared
  end

  def stream_transaction_update
    broadcast_transaction(self)
  end

  def stream_repetition_change
    transactions.each { |transaction| broadcast_transaction(transaction) }
  end

  private

  def broadcast_create(transaction, shared)
    broadcast_prepend_to "group_#{self.group.id}", partial: 'transactions/wrapper', locals: { transaction: self, highlight: true }, target: "transactions-results-#{shared}"
    broadcast_prepend_to "user_#{self.user.id}", partial: 'transactions/wrapper', locals: { transaction: self, highlight: true }, target: "transactions-results-#{shared}"
  end

  def broadcast_transaction(transaction)
    broadcast_update_to "group_#{transaction.group.id}", partial: 'transactions/transaction', locals: { transaction: transaction, highlight: true }, target: "transaction_#{transaction.id}"
    broadcast_balance_change(true)
    broadcast_balance_change(false)
  end

  def broadcast_balance_change(shared)
    interactor = BalanceCalculator.call(source: self.user, timing: :this_month, shared: shared)

    broadcast_update_to "user_#{self.user.id}", partial: 'transactions/balance', locals: { balance: interactor.balance }, target: interactor.identifier
  end
end
