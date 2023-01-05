class User < ApplicationRecord
  belongs_to :group
  has_many :transactions

  before_create :assign_slug

  def to_param
    slug
  end

  def initials
    name.split.map(&:first).join.upcase
  end

  private

  def assign_slug
    self.slug ||= SecureRandom.alphanumeric(10).downcase
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#
# Indexes
#
#  index_users_on_group_id  (group_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
