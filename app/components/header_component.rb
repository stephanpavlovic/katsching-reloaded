# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  attr_reader :timing, :shared, :source

  def initialize(source:, timing:, shared:)
    @source = source
    @timing = timing&.to_sym || :this_month
    @shared = shared
  end

  private

  def group?
    source.is_a?(Group)
  end

  def name
    source.name
  end

  def group
    group? ? source : source.group
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
    options = { timing: params[:timing] }
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

  def balance_identifier
    base = "#{source.class.name.downcase}_#{source.id}"
    base += "_balance_#{timing}_#{@shared ? 'shared' : 'personal'}"
  end

  def balance_url
    helpers.balance_transactions_path(
      source_id: source.id,
      source_type: source.class.to_s,
      timing: timing,
      shared: shared,
      identifier: balance_identifier
    )
  end

end
