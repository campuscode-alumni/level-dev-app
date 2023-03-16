class RentalRecord < ActiveRecord::Base
  self.table_name = 'rentals'

  belongs_to :client
  belongs_to :category
  belongs_to :subsidiary
end
