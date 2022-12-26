class Transaction < ApplicationRecord
  belongs_to :user

  monetize :amount_cents

  scope :this_month, -> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :last_month, -> { where(created_at: Time.zone.now.last_month.beginning_of_month..Time.zone.now.last_month.end_of_month) }

  def self.balance
    Money.new(all.sum(:amount_cents))
  end
end

# == Schema Information
#
# Table name: transactions
#
#  id           :bigint           not null, primary key
#  amount_cents :integer
#  category     :string
#  date         :date
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_transactions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
