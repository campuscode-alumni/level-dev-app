# frozen_string_literal: true

FactoryBot.define do
  factory :rental do
    start_date { '2019-11-13' }
    end_date { '2019-11-13' }
    client
    category
    subsidiary
    status { :scheduled }
    price_projection { 100 }

    after(:build) do |rental|
      car_model = create(:car_model, category: rental.category)
      create(:car, car_model: car_model)
    end

    trait :without_callbacks do
      after(:build) do |rental|
        rental.class.skip_callback(:create, :generate_reservation_code)
      end

      after(:create) do |rental|
        rental.class.set_callback(:create, :generate_reservation_code)
      end
    end
  end
end
