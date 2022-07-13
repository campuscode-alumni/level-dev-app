# frozen_string_literal: true

require 'rails_helper'

describe CarModelDecorator do
  include Rails.application.routes.url_helpers

  describe '#manufacture_name' do
    it 'should render a manufacture name' do
      manufacture = create(:manufacture, name: 'Fiat')
      car_model = build(:car_model, manufacture: manufacture)
      expect(car_model.decorate.manufacture_name).to eq('Fiat')
    end

    it 'should render N/A without manufacture' do
      car_model = build(:car_model, manufacture: nil)
      expect(car_model.decorate.manufacture_name).to eq('N/A')
    end
  end

  describe '#photo_url' do
    it 'should return a photo if present' do
      car_model = build(:car_model, :with_photo)
      expect(car_model.decorate.photo_url).to include('test.host')
    end

    it 'should return a photo if present' do
      car_model = build(:car_model)
      expect(car_model.decorate.photo_url).to eq('https://via.placeholder.com/500')
    end
  end
end
