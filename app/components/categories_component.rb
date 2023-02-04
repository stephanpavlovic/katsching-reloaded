# frozen_string_literal: true

class CategoriesComponent < ViewComponent::Base
  def initialize(transactions:)
    @transactions = transactions.where("amount_cents < 0").where(shared: true)
  end

  private

  def data
    result = []
    all_cents = @transactions.sum(&:amount_cents).abs
    index = 0
    @transactions.group_by(&:user_id).each do |user, transactions|
      user = User.find(user)
      sum = transactions.sum(&:amount_cents).abs
      result << {
        name: user.name,
        sum: Money.new(sum),
        percentage: (sum.to_f / all_cents.to_f * 100).round,
        color: colors[index]
      }
      index += 1
    end
    result.sort_by { |r| r[:name] }
  end

  def colors
    ['#4051b5', '#890d3b', '#4051b5', '#890d3b']
  end
end
