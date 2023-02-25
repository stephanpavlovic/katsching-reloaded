class User < ApplicationRecord
  authenticates_with_sorcery!
  belongs_to :group
  has_many :transactions
  has_many :repetitions

  before_create :assign_slug

  validates :email, presence: true, uniqueness: true

  def to_param
    slug
  end

  def initials
    name.first.upcase
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
#  id                           :bigint           not null, primary key
#  crypted_password             :string
#  email                        :string
#  magic_login_email_sent_at    :datetime
#  magic_login_token            :string
#  magic_login_token_expires_at :datetime
#  name                         :string
#  remember_me_token            :string
#  remember_me_token_expires_at :datetime
#  salt                         :string
#  slug                         :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  group_id                     :bigint           not null
#
# Indexes
#
#  index_users_on_group_id           (group_id)
#  index_users_on_magic_login_token  (magic_login_token)
#  index_users_on_remember_me_token  (remember_me_token)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
