class TransactionsController < ApplicationController
  def new
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.new(date: Date.today)
  end

  def create
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.new(transaction_params)
    if @transaction.save
      redirect_to user_path(@user.slug)
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :name, :category, :date)
  end
end
