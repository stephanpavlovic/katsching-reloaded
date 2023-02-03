class CreateRecurringTransactionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Repetition.active.where('next_iteration <= ?', Date.today).each do |repetition|
      repetition.create_next_transaction!
    end
  end
end
