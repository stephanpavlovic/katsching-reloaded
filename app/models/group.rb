class Group < ApplicationRecord
  before_create :assign_slug

  private

  def assign_slug
    self.slug ||= SecureRandom.alphanumeric(10).downcase
  end
end
