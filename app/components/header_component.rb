# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  attr_reader :name, :balance

  def initialize(name:, balance:)
    @name = name
    @balance = balance
  end

end
