class Group < ApplicationRecord
  has_many :users
  has_many :transactions, through: :users

  accepts_nested_attributes_for :users

  before_create :assign_slug

  def balance
    Money.new(transactions.balance)
  end

  private

  def assign_slug
    self.slug ||= SecureRandom.alphanumeric(10).downcase
  end
end

# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
