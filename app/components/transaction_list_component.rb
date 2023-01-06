# frozen_string_literal: true

class TransactionListComponent < ViewComponent::Base

  def initialize(source:, timing:, only_shared: )
    @source = source
    @timing = timing
    @only_shared = only_shared
  end

  private

  def url
    transactions_path(source: { id: @source.slug, type: @source.class.name }, timing: @timing, shared: @only_shared)
  end

end
