# frozen_string_literal: true

class CarModelPresenter < SimpleDelegator
  delegate :content_tag, :concat, to: :helpers

  def options_list
    return '' if car_options.blank?

    content_tag :span do
      car_options.split(',').map do |option|
        concat content_tag(:p, option.strip)
      end
    end
  end

  private

  def helpers
    ApplicationController.helpers
  end
end
