class TransactionsController < ApplicationController
  def new
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.new(date: Date.today)
  end

  def create
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.new(transaction_params)
    if @transaction.save
      render turbo_stream: turbo_stream.update("new_transaction", partial: 'users/new_transaction', locals: { user: current_user })
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.find(params[:id])
    render turbo_stream: update_with_form
  end

  def show
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.find(params[:id])
    render turbo_stream: replace_with_show
  end

  def update
    @user = User.find_by(slug: params[:user_id])
    @transaction = @user.transactions.find(params[:id])
    if @transaction.update(transaction_params)
      render turbo_stream: replace_with_show(highlight: true)
    else
      render turbo_stream: update_with_form
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
    @categories = @transactions.map(&:category).uniq
    render partial: '/transactions/list', locals: {transactions: @transactions}
  end

  def balance
    source = params.dig(:source_type).constantize.find(params.dig(:source_id))
    shared = shared(default: source.is_a?(User))
    interactor = BalanceCalculator.call(source: source, timing: timing, shared: shared)

    render turbo_stream: turbo_stream.update(interactor.identifier, partial: '/transactions/balance', locals: { balance: interactor.balance })
  end

  private

  def replace_with_show(highlight: false)
    turbo_stream.replace(
      "transaction_#{@transaction.id}",
      partial: 'transactions/transaction',
      locals: {transaction: @transaction, highlight: highlight}
    )
  end

  def update_with_form
    url = user_transaction_path(@user.slug, @transaction)
    turbo_stream.update(
      "transaction_#{@transaction.id}",
      partial: 'transactions/form',
      locals: {url: url, transaction: @transaction}
    )
  end

  def transaction_search_results
    if params[:source].blank?
      base = Transaction.all
    else
      @source = params.dig(:source, :type).constantize
      base = @source.find_by(slug: params.dig(:source, :id)).transactions
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
