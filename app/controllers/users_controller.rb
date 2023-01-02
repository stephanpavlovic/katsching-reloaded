class UsersController < ApplicationController
  def show
    @user = User.find_by(slug: params[:id].downcase)
    @transactions = @user.transactions.this_month.order(date: :desc, created_at: :desc)
    @balance = @user.transactions.this_month.balance
  end
end
