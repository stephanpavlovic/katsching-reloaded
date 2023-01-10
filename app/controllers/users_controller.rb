class UsersController < ApplicationController
  skip_before_action :require_login, only: [:search]

  def show
    @user = User.find_by!(slug: params[:id].downcase)
    @shared = shared(default: false)
    @balance = transactions.balance
  end

  def search
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_magic_login_instructions!
      redirect_to root_path
    else
      redirect_to new_group_path(email: params[:email])
    end
  end

  private

  def transactions
    result = @user.transactions
    result = result.shared if @shared
    result.order(date: :desc).send(timing)
  end
end
