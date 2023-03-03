# frozen_string_literal: true

class Rental < ApplicationRecord
  before_create :generate_reservation_code
  belongs_to :client
  belongs_to :category
  belongs_to :subsidiary
  validates :start_date, :end_date, :price_projection, presence: true
  validate :start_cannot_be_greater_than_end, :price_cannot_be_zero
  validate :cars_available, on: :create
  has_many :rental_items, dependent: :destroy
  accepts_nested_attributes_for :rental_items
  enum status: { scheduled: 0, in_review: 5, ongoing: 10, finalized: 15 }

  def calculate_price_projection!
    self.price_projection = 0
    return unless start_date && end_date && category

    days = (end_date - start_date).to_i
    self.price_projection = days * category.daily_rate
  end

  def calculate_final_price
    days = (end_date - start_date).to_i
    value = 0
    rental_items.each { |rental_item| value += rental_item.daily_rate }
    days * value
  end

  def start_cannot_be_greater_than_end
    return 0 if start_date.nil? || end_date.nil?

    errors.add(:start_date, 'não pode ser maior que data de término.') if start_date > end_date
  end

  def available_cars
    category.cars.where(status: :available)
  end

  def cars_available
    errors.add(:category, 'Não há carros disponíveis na categoria escolhida.') if cars_available_at_date_range
  end

  def price_cannot_be_zero
    errors.add(:price_projection, 'não pode ser zero.') if price_projection <= 0
  end

  private

  def cars_available_at_date_range
    available_cars_at_category = Car.where(status: :available).joins(:car_model)
                                    .where(car_models: { category: category })
    scheduled_rentals.count >= available_cars_at_category.count
  end

  def scheduled_rentals
    @scheduled_rentals ||=
      Rental.where(category: category)
            .where(start_date: start_date..end_date)
            .or(Rental.where(category: category)
                .where(end_date: start_date..end_date))
  end

  def generate_reservation_code
    self.reservation_code = generate_random_token
    generate_reservation_code if Rental.exists?(reservation_code: reservation_code)
  end

  def generate_random_token
    charset = Array('A'..'Z') + Array(0..9)
    Array.new(6) { charset.sample }.join
  end
end
