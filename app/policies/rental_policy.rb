# frozen_string_literal: true

class RentalPolicy
  def initialize(user, rental)
    @user   = user
    @rental = rental
  end

  def allowed?
    admin? || employee?
  end

  private

  attr_reader :user, :rental
  delegate :admin?, to: :user

  def employee?
    rental.subsidiary == user.subsidiary
  end
end
