# frozen_string_literal: true

class RentalPresenter
  delegate :content_tag, :t, to: :helpers

  def initialize(rental)
    @rental = rental
  end

  def status
    color_class = STATUS_COLORS.fetch(rental.status&.to_sym, 'primary')
    content_tag :span, t(rental.status, default: 'Status não existe'), class: "badge bg-#{color_class}"
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

  def method_missing(event, *args, &block)
    rental.public_send(event, *args, &block)
  end

  def respond_to_missing?(event, include_private = false)
    rental.respond_to?(event, include_private)
  end
end
