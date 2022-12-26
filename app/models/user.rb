class User < ApplicationRecord
  belongs_to :group

  before_create :assign_slug

  private

  def assign_slug
    self.slug ||= SecureRandom.alphanumeric(10)
  end
end
