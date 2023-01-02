class RepetitionsController < ApplicationController
  def new
    @transaction = Transaction.find(params[:transaction_id])
    @repetition = Repetition.new
  end

  def create
    @repetition = Repetition.new(repetition_params)
    @transaction = Transaction.find(params[:transaction_id])
    if @repetition.save
      @transaction.update(repetition: @repetition)
      @repetition.set_inital_iteration!
      redirect_to user_path(@transaction.user.slug)
    else
      render :new
    end
  end

  def edit
    @repetition = Repetition.find(params[:id])
    @transaction = Transaction.find(params[:transaction_id])
  end

  def update
    @repetition = Repetition.find(params[:id])
    @transaction = Transaction.find(params[:transaction_id])
    if @repetition.update(repetition_params)
      redirect_to user_path(@transaction.user.slug)
    else
      render :edit
    end
  end

  private

  def repetition_params
    params.require(:repetition).permit(:timing)
  end
end
