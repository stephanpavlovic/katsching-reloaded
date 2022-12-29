class GroupsController < ApplicationController
  def show
    @group = Group.find_by(slug: params[:id].downcase)
    @transactions = @group.transactions.past.order(date: :desc, created_at: :desc).limit(5)
    @balance = @group.transactions.past.balance
  end
end
