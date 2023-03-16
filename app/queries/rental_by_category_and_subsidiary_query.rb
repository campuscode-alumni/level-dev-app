# frozen_string_literal: true

class RentalByCategoryAndSubsidiaryQuery
  def initialize(start_date:, end_date:)
    @start_date = start_date
    @end_date   = end_date
  end

  def call
    # sql = <<~SQL.squish
    #   SELECT s.name AS subsidiary, c.name AS category, COUNT(*) AS total
    #   FROM rentals r
    #   LEFT JOIN subsidiaries s ON s.id == r.subsidiary_id
    #   LEFT JOIN categories c ON c.id == r.category_id
    #   WHERE r.start_date BETWEEN '#{start_date}' AND '#{end_date}'
    #   GROUP BY c.id, s.id
    #   ORDER BY total DESC;
    # SQL

    sql = Rental
      .where(start_date: start_date..end_date)
      .left_joins(:subsidiary, :category)
      .select('subsidiaries.name AS subsidiary',
              'categories.name AS category',
              'COUNT(*) AS total'
             )
      .group('subsidiaries.name', 'categories.name')
      .order('total DESC, subsidiary')
      .to_sql

    ActiveRecord::Base.connection.execute(sql)
  end

  private

  attr_reader :start_date, :end_date
end
