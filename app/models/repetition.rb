class Repetition < ApplicationRecord
  TIMINGS = %w[weekly monthly yearly quartaly halfyearly].freeze

  has_many :transactions

  scope :active, -> { where(active: true) }

  def create_next_transaction!
    return if original_transaction.blank? || next_iteration.blank?

    transactions.create(date: next_iteration, amount: original_transaction.amount, name: original_transaction.name, category: original_transaction.category, user: original_transaction.user, shared: original_transaction.shared)
    set_next_iteration!(calculate_next_iteration(next_iteration))
  end

  def original_transaction
    transactions.order(:date).last
  end

  def user
    original_transaction&.user
  end

  def calculate_next_iteration(date)
    case timing
    when 'weekly'
      date + 1.week
    when 'biweekly'
      date + 2.weeks
    when 'monthly'
      date + 1.month
    when 'quartaly'
      date + 3.months
    when 'halfyearly'
      date + 6.months
    when 'yearly'
      date + 1.year
    end
  end

  def set_inital_iteration!
    update(next_iteration: calculate_next_iteration(original_transaction.date)) if next_iteration.blank?
  end

  def set_next_iteration!(date)
    update(next_iteration: date)
  end

end

# == Schema Information
#
# Table name: repetitions
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  next_iteration :datetime
#  timing         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
