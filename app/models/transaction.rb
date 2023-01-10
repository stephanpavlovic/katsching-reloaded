class Transaction < ApplicationRecord
  include Streaming

  belongs_to :user
  belongs_to :repetition, optional: true

  CATEGORIES = %w[groceries leisure mobility savings insurance holidays rent salary other].freeze

  monetize :amount_cents

  scope :this_month, -> { where(date: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :last_month, -> { where(date: Time.zone.now.last_month.beginning_of_month..Time.zone.now.last_month.end_of_month) }
  scope :year, -> { where(date: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year) }
  scope :past, -> { where('date <= ?', Date.today) }
  scope :shared, -> { where(shared: true) }

  before_validation :update_repetition, if: :will_save_change_to_date?

  after_update :stream_transaction_update
  after_destroy :stream_transaction_destroy

  def update_repetition
    if repetition.present? && repetition.original_transaction.id == id
      repetition.set_next_iteration!(repetition.calculate_next_iteration(date))
    end
  end

  def group
    user.group
  end

  def incoming?
    amount&.positive?
  end

  def outgoing?
    !amount&.positive?
  end

  def future?
    date > Date.today
  end


  def self.balance
    Money.new(all.sum(:amount_cents))
  end
end

# == Schema Information
#
# Table name: transactions
#
#  id            :bigint           not null, primary key
#  amount_cents  :integer
#  category      :string
#  date          :date
#  name          :string
#  shared        :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  repetition_id :bigint
#  user_id       :bigint           not null
#
# Indexes
#
#  index_transactions_on_category  (category)
#  index_transactions_on_name      (name)
#  index_transactions_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
