# frozen_string_literal: true

class CarModel < ApplicationRecord
  has_one_attached :photo
  belongs_to :manufacture, optional: true
  belongs_to :fuel_type
  belongs_to :category
  has_many :cars, dependent: :destroy
  validates :name, presence: true
  validates :year, presence: true
  validates :car_options, presence: true
end
