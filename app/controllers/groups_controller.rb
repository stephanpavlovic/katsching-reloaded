class GroupsController < ApplicationController
  def show
    @group = Group.find_by(slug: params[:id].downcase)
    @transactions = @group.transactions.order(date: :desc, created_at: :desc).limit(5)
  end
end
