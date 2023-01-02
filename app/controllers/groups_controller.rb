class GroupsController < ApplicationController
  def show
    @group = Group.find_by(slug: params[:id].downcase)
    @transactions = @group.transactions.this_month.order(date: :desc, created_at: :desc)
    @balance = @group.transactions.this_month.balance
  end
end
