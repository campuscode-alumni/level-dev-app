# frozen_string_literal: true

class RentalCalculator
  def initialize(start_date:, end_date:, category:)
    @start_date = start_date
    @end_date = end_date
    @category = category
  end

  def calculate
    return 0 unless start_date && end_date && category

    days * category.daily_rate
  end

  private

  def days
    @days ||= (end_date - start_date).to_i
  end

  attr_reader :start_date, :end_date, :category
end
