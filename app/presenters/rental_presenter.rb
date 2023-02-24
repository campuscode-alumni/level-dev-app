class RentalPresenter
  def initialize(rental)
    @rental = rental
  end

  STATUS_COLORS = {
    scheduled: 'primary',
    ongoing: 'warning',
    finalized: 'success'
  }.freeze

  def status
    color_class = STATUS_COLORS.fetch(rental.status&.to_sym, 'primary')
    "<span class=\"badge bg-#{color_class}\">#{I18n.t(rental.status, default: 'Status não existe')}</span>"
    # content_tag :span, I18n.t(rental.status, default: 'Status não existe'), class: "badge bg-#{color_class}"
  end

  private

  attr_reader :rental

  def method_missing(event, *args, &block)
    rental.public_send(event, *args, &block)
  end

  def respond_to_missing?(event, include_private = false)
    rental.respond_to?(event, include_private)
  end
end
