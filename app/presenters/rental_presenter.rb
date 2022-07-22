# frozen_string_literal: true

class RentalPresenter < SimpleDelegator
  def initialize(rental, user = NilUser.new, policy = RentalPolicy)
    super(rental)
    @user   = user
    @policy = policy
  end

  def status
    return '' unless super

    color_class = STATUS_COLOR[super.to_sym]
    content_tag :span, t(super), class: "badge bg-#{color_class}"
  end

  def confirmation_form
    return { plain: '' } unless policy.new(user, self).allowed?

    { partial: 'rentals/confirmation_form' }
  end

  private

  attr_reader :rental, :user, :policy

  STATUS_COLOR = {
    scheduled: 'warning',
    ongoing: 'primary',
    finalized: 'success',
    in_review: 'secondary'
  }.freeze

  delegate :content_tag, :t, to: :helpers

  def helpers
    ApplicationController.helpers
  end
end
