# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  attr_reader :name, :balance, :timing, :shared

  def initialize(name:, balance:, timing:, shared:)
    @name = name
    @balance = balance
    @timing = timing&.to_sym || :this_month
    @shared = shared
  end

  private

  def group
    helpers.current_user.group
  end

  def next_url
    case timing
    when :this_month
      helpers.url_for(shared: @shared, timing: :last_month)
    when :last_month
      helpers.url_for(shared: @shared, timing: :year)
    when :year
      helpers.url_for(shared: @shared, timing: :this_month)
    end
  end

  def switch_url
    options = {timing: params[:timing]}
    options[:shared] = !@shared
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
