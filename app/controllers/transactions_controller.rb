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

  def index
    @transactions = transaction_search_results
    render partial: '/transactions/list', locals: {transactions: @transactions}
  end

  private

  def transaction_search_results
    if params[:source].blank?
      base = Transaction.all
    else
      base = params.dig(:source, :type).constantize.find_by(slug: params.dig(:source, :id)).transactions
    end
    @timing = timing
    base = base.send(@timing)
    base = base.shared if shared(default: false)
    @q = base.ransack(params[:q])
    @q.result(distinct: true).order(date: :desc, created_at: :desc)
  end

  def transaction_params
    par = params.require(:transaction).permit(:amount, :name, :category, :date, :shared)
    par[:amount] = par[:amount].to_f * -1 if params[:outgoing]
    par
  end
end
