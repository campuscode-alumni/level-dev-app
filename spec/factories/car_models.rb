# frozen_string_literal: true

FactoryBot.define do
  factory :car_model do
    name { 'Sedan' }
    year { '1999' }
    manufacture
    motorization { 'Cavalos' }
    fuel_type
    category
    car_options { 'Opções extras' }

    trait :with_photo do
      photo do
        fixture_file_upload(Rails.root.join('spec/fixtures/150x150.png'),
                            'image/png')
      end
    end
  end
end
