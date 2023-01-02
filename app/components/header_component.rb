# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  attr_reader :name, :balance, :timing, :link

  def initialize(name:, balance:, timing: :this_month, link: nil)
    @name = name
    @balance = balance
    @timing = timing
    @link = link
  end

  private

  def label
    case timing
    when :this_month
      I18n.l(Date.today, format: '%B')
    when :last_month
      I18n.l(1.month.ago, format: '%B')
    when :year
      I18n.l(Date.today, format: '%Y')
    end
  end

end
