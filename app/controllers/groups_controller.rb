class GroupsController < ApplicationController
  def show
    @group = Group.find_by(slug: params[:id].downcase)
    @shared = shared(default: true)
    @transactions = transactions.order(date: :desc, created_at: :desc)
    @balance = @transactions.balance
  end

  def new
    @group = Group.new
  end

  def create

  end

  private

  def transactions
    result = @group.transactions.send(timing)
    result = result.shared if @shared
    result
  end
end
