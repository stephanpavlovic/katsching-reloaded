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

  def edit
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.find(params[:id])
  end

  def update
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to user_path(@user.slug)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.find(params[:id])
    @transaction.destroy
    redirect_to user_path(@user.slug)
  end

  private

  def transaction_params
    par = params.require(:transaction).permit(:amount, :name, :category, :date, :shared)
    par[:amount] = par[:amount].to_f * -1 if params[:outgoing]
    par
  end
end
