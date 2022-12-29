class CreateRecurringTransactionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Repitition.active.where('next_iteration <= Date.today').each do |repitition|
      repetition.create_next_transaction!
    end
  end
end
