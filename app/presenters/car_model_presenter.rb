# frozen_string_literal: true

class CarModelPresenter < SimpleDelegator
  delegate :content_tag, :concat, to: :helpers

  def car_options_list
    return '' if car_options.blank?

    content_tag :ul do
      car_options.split(',').map do |option|
        concat content_tag :li, option.strip
      end
    end
  end

  private

  def helpers
    ApplicationController.helpers
  end
end
