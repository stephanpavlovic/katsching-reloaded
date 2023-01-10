module ApplicationHelper
  def svg(name)
    file_path = Rails.root.join('app', 'assets', 'images', "#{name}.svg")
    return File.read(file_path).html_safe if File.exist?(file_path)

    "[svg '#{name}' not found]"
  end

  def category_options
    Transaction::CATEGORIES.map { |category| [t("categories.#{category}"), category] }
  end

  def timing_options
    Repetition::TIMINGS.map { |timing| [t("repetitions.timings.#{timing}"), timing] }
  end

  def format_money(money)
    return nil unless money.instance_of?(Money)

    money.format(format: "%n%u", symbol: true, no_cents_if_whole: true)
  end

  def balance_money_tag(money)
    return nil unless money.instance_of?(Money)

    content_tag(:span, format_money(money.abs), class: "Balance #{money.positive? ? 'positive' : 'negative'}")
  end
end
