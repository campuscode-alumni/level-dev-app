# frozen_string_literal: true

module RentalHelper
  STATUS_COLORS = {
    scheduled: 'primary',
    ongoing: 'warning',
    finalized: 'success'
  }.freeze

  def status(status)
    color_class = STATUS_COLORS.fetch(status&.to_sym, 'primary')
    content_tag :span, t(status, default: 'Status não existe'), class: "badge bg-#{color_class}"
  end
end
