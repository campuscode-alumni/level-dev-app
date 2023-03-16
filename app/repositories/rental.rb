class Rental
  include ActiveModel::Model

  ATTRIBUTES = %i[start_date end_date client_id]

  attr_accessor(:id, :created_at, :updated_at, *ATTRIBUTES)

  validates :client_id, presence: true

  def attributes
    ATTRIBUTES.index_with do |attribute|
      send(attribute)
    end
  end
end
