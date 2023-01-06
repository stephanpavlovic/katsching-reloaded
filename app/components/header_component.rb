# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  attr_reader :name, :balance, :timing, :link, :shared

  def initialize(name:, balance:, timing:, shared:, link: nil)
    @name = name
    @balance = balance
    @timing = timing&.to_sym || :this_month
    @link = link
    @shared = shared
  end

  private

  def next_url
    case timing
    when :this_month
      helpers.url_for(timing: :last_month)
    when :last_month
      helpers.url_for(timing: :year)
    when :year
      helpers.url_for(timing: :this_month)
    end
  end

  def switch_url
    options = {timing: params[:timing]}
    options[:shared] = false if @shared
    url_for(options)
  end

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
