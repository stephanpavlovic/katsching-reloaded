module Streaming
  extend ActiveSupport::Concern

  def stream_transaction_destroy
    broadcast_remove_to "group_#{group.id}", target: "transaction_#{id}"
  end

  def stream_transaction_update
    broadcast_transaction(self)
  end

  def stream_repetition_change
    transactions.each { |transaction| broadcast_transaction(transaction) }
  end

  private

  def broadcast_transaction(transaction)
    broadcast_update_to "group_#{transaction.group.id}", partial: 'transactions/transaction', locals: { transaction: transaction, highlight: true }, target: "transaction_#{transaction.id}"
  end
end
