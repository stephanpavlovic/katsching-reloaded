class BalanceCalculator
  include Interactor

  delegate :source, :timing, :shared, to: :context

  def call
    context.balance = calc_balance
    context.identifier = identifer
  end

  private

  def calc_balance
    result = source.transactions
    result = result.shared if shared
    result = result.send(timing).order(date: :desc)
    result.balance
  end

  def identifer
    base = "#{source.class.name.downcase}_#{source.id}"
    base += "_balance_#{timing}_#{shared ? 'shared' : 'personal'}"
  end

end
