# frozen_string_literal: true

class RentalScheduler
  prepend Command

  def initialize(rental, calculator = RentalCalculator)
    @rental = rental
    @calculator = calculator
  end

  def call
    rental.price_projection = calculator.new(
      start_date: rental.start_date, end_date: rental.end_date, category: rental.category
    ).calculate
    rental.status = :scheduled
    rental.save
    errors.concat(rental.errors.full_messages)
  end

  private

  attr_reader :rental, :calculator
end