# frozen_string_literal: true

class CarModelDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def manufacture_name
    manufacture&.name&.presence || 'N/A'
  end

  def photo_url
    return polymorphic_path(photo) if photo.attached?

    'https://picsum.photos/200/300'
  end
end
