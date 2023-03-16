class RentalRepository
  extend self

  def find(id)
    RentalRecord.find(id)
  end

  def save(rental)
    return false unless rental.valid?

    record = RentalRecord.assign_attributes(rental.attributes)
    record.save
  end
end
