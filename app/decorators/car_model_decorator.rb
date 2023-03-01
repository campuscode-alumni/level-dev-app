# frozen_string_literal: true

class CarModelDecorator < Draper::Decorator
  delegate_all

  def manufacture_name
    manufacture&.name&.presence || 'N/A'
  end
end
