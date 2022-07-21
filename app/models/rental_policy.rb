# frozen_string_literal: true

class RentalPolicy
  def initialize(user, rental)
    @user = user
    @rental = rental
  end

  def allowed?
    user.admin? || employee?
  end

  private

  def employee?
    user.subsidiary == rental.subsidiary
  end

  attr_reader :user, :rental
end
