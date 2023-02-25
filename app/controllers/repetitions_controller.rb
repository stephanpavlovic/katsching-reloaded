class RepetitionsController < ApplicationController
  def new
    @transaction = Transaction.find(params[:transaction_id])
    @repetition = Repetition.new
  end

  def create
    @repetition = Repetition.new(repetition_params.merge(user: current_user)
    @transaction = Transaction.find(params[:transaction_id])
    if @repetition.save
      @transaction.update(repetition: @repetition)
      @repetition.set_inital_iteration!
      render turbo_stream: render_replace
    else
      render :new
    end
  end

  def edit
    @repetition = Repetition.find(params[:id])
    @transaction = Transaction.find(params[:transaction_id])
    render turbo_stream: turbo_stream.update(
      "repetition_transaction_#{@transaction.id}",
      partial: 'repetitions/form',
      locals: {transaction: @transaction, repetition: @repetition}
    )
  end

  def update
    @repetition = Repetition.find(params[:id])
    @transaction = Transaction.find(params[:transaction_id])
    if @repetition.update(repetition_params)
      render turbo_stream: render_replace
    else
      render :edit
    end
  end

  def destroy
    @repetition = Repetition.find(params[:id])
    @transaction = Transaction.find(params[:transaction_id])
    @repetition.destroy
    render turbo_stream: render_replace
  end

  private

  def render_replace
    turbo_stream.replace(
      "wrapper_transaction_#{@transaction.id}",
      partial: '/transactions/wrapper',
      locals: {transaction: @transaction, highlight: true}
    )
  end

  def repetition_params
    params.require(:repetition).permit(:timing)
  end
end
