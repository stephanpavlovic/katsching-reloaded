class UsersController < ApplicationController
  def show
    @user = User.find_by(slug: params[:id].downcase)
    @transactions = @user.transactions.this_month.order(date: :desc, created_at: :desc)
    @balance = @user.transactions.this_month.balance
  end

  def search
    @user = User.find_by(email: params[:email])
    if @user
      redirect_to user_path(@user)
    else
      redirect_to new_group_path(email: params[:email])
    end
  end

  def new
    @user = User.new(email: params[:email])
  end
end
