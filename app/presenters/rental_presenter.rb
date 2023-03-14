# frozen_string_literal: true

class RentalPresenter < SimpleDelegator
  delegate :content_tag, :t, :render, to: :helpers

  def initialize(rental, user = NilUser.new, policy = RentalPolicy)
    super(rental)
    @user   = user
    @policy = policy
  end

  def status
    color_class = STATUS_COLORS.fetch(super&.to_sym, 'primary')
    content_tag :span, t(super, default: 'Status não existe'), class: "badge bg-#{color_class}"
  end

  # TODO: substituir por view context
  def confirmation_form
    return { plain: '' } unless policy.new(user, self).allowed?

    { partial: 'rentals/confirmation_form' }
  end

  private

  STATUS_COLORS = {
    scheduled: 'primary',
    ongoing: 'warning',
    finalized: 'success'
  }.freeze

  attr_reader :user, :policy

  def helpers
    ApplicationController.helpers
  end
end
