class UsersController < ApplicationController
  def show
    @user = User.find_by!(slug: params[:id].downcase)
    @shared = shared(default: false)
    @transactions = transactions
    @balance = @transactions.balance
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

  private

  def transactions
    result = @user.transactions.order(date: :desc).send(timing)
    result = result.shared if @shared
    result
  end
end
