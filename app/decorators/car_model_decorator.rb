# frozen_string_literal: true

class CarModelDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  def manufacture_name
    manufacture&.name || 'N/A'
  end

  def photo_url
    return 'https://via.placeholder.com/500' unless photo.attached?

    rails_blob_url(photo)
  end
end
