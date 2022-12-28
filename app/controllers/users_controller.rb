class UsersController < ApplicationController
  def show
    @user = User.find_by(slug: params[:id].downcase)
    @transactions = @user.transactions.order(date: :desc, created_at: :desc)
  end
end
