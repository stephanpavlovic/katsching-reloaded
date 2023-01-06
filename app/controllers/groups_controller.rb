class GroupsController < ApplicationController
  def show
    @group = Group.find_by(slug: params[:id].downcase)
    @shared = shared(default: true)
    @transactions = transactions
    @balance = @transactions.balance
  end

  def new
    @group = Group.new
  end

  def create

  end

  private

  def transactions
    result = @group.transactions.order(date: :desc, created_at: :desc).send(timing)
    result = result.shared if @shared
    result
  end
end
