class RepetitionsController < ApplicationController
  def new
    @transaction = Transaction.find(params[:transaction_id])
    @repetition = Repetition.new
  end

  def create
    @transaction = Transaction.find(params[:transaction_id])
    @repetition = Repetition.new(repetition_params.merge(transaction: @transaction))
    debugger
    if @repetition.save
      redirect_to user_path(@transaction.user.slug)
    else
      render :new
    end
  end

  private

  def repetition_params
    params.require(:repetition).permit(:timing)
  end
end
