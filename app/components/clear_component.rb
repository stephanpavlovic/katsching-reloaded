# frozen_string_literal: true

class ClearComponent < ViewComponent::Base
  attr_reader :frame
  def initialize(frame:)
    @frame = frame
  end
end
