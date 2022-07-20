# frozen_string_literal: true

class RentalScheduler
  prepend Command

  def initialize(rental, calculator = RentalCalculator)
    @rental = rental
    @calculator = calculator
  end

  def call
    rental.status = :scheduled
    rental.price_projection = calculator.new(rental).calculate
    rental.save
  end

  private

  attr_reader :rental, :calculator
end
