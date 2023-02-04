# frozen_string_literal: true

class CategoriesComponent < ViewComponent::Base
  def initialize(transactions:)
    @transactions = transactions.where("amount_cents < 0").where(shared: true)
  end

  private

  def data
    chart_data = []
    @transactions.group_by(&:user_id).each do |user, transactions|
      user = User.find(user)
      chart_data << {
        name: user.name,
        data: group_transactions(transactions)
      }
    end
    chart_data
  end

  def group_transactions(transactions)
    transactions.group_by(&:category).map do |category, transactions|
      [category, transactions.sum(&:amount_cents).abs / 100]
    end
  end
end
