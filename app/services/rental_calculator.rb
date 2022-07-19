# frozen_string_literal: true

class RentalCalculator
  def initialize(rental)
    @rental = rental
  end

  delegate :start_date, :end_date, :category, to: :rental

  def calculate
    days * category.daily_rate
  end

  private

  def days
    return 0 unless end_date && start_date

    @days ||= (end_date - start_date).to_i
  end

  attr_reader :rental
end
