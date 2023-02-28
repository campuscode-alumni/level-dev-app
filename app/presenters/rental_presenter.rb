# frozen_string_literal: true

class RentalPresenter < SimpleDelegator
  delegate :content_tag, :t, to: :helpers

  def status
    color_class = STATUS_COLORS.fetch(super&.to_sym, 'primary')
    content_tag :span, t(super, default: 'Status não existe'), class: "badge bg-#{color_class}"
  end

  private

  STATUS_COLORS = {
    scheduled: 'primary',
    ongoing: 'warning',
    finalized: 'success'
  }.freeze

  attr_reader :rental

  def helpers
    ApplicationController.helpers
  end
end
