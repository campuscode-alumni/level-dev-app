# frozen_string_literal: true

class RentalsByCategoryAndSubsidiaryQuery
  def initialize(start_date, end_date)
    @start_date = start_date.to_date
    @end_date   = end_date.to_date
  end

  def call
    # Rental
    #   .joins(:subsidiary, :category)
    #   .select('subsidiaries.name AS subsidiary',
    #           'categories.name AS category',
    #           'COUNT(*) AS total')
    #   .where(start_date: start_date..end_date)
    #   .group('subsidiaries.id', 'categories.id')
    #   .order('total DESC')

    query = <<~SQL.squish
      SELECT s.name AS subsidiary, c.name AS category, COUNT(*) AS total
      FROM rentals r
      INNER JOIN subsidiaries s ON s.id = r.subsidiary_id
      INNER JOIN categories c ON c.id = r.category_id
      WHERE r.start_date BETWEEN '#{start_date}' AND '#{end_date}'
      GROUP BY s.id, c.id
      ORDER BY total DESC
    SQL

    ActiveRecord::Base.connection.execute(query)
  end

  private

  attr_reader :start_date, :end_date
end

# def initialize(**params)
#   @params = params
#   @scoped = Rental.all
# end
#
# def call
#   scoped = filter_by_price(params[:price])
#   scoped = filter_by_subsidiary(params[:subsidiary])
#   scoped = filter_by_category(params[:category])
#   scoped = sort(params[:sort])
#   scoped = paginate(params[:page])
#   scoped
# end
#
# def filter_by_price(query = nil)
#   query ? scoped.where(price_projection: query..) : scoped
# end
#
# def filter_by_subsidiary(query = nil)
#   query ? scoped.where(subsidiary: query) : scoped
# end
