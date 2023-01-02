class GroupsController < ApplicationController
  def show
    @group = Group.find_by(slug: params[:id].downcase)
    @transactions = transactions.order(date: :desc, created_at: :desc)
    @balance = transactions.balance
  end

  private

  def transactions
    @group.transactions.this_month.shared
  end
end
