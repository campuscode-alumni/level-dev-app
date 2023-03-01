# frozen_string_literal: true

require 'rails_helper'

describe CarModelDecorator do
  describe '#manufacture_name' do
    it 'should render a manufacture name' do
      manufacture = create(:manufacture, name: 'Fiat')
      car_model = build(:car_model, manufacture: manufacture)
      expect(car_model.decorate.manufacture_name).to eq('Fiat')
    end

    it 'should render N/A without manufacture name' do
      car_model = build(:car_model, manufacture: nil)
      expect(car_model.decorate.manufacture_name).to eq('N/A')
    end

    it 'should render N/A with a manufacture without name' do
      manufacture = build(:manufacture, name: '')
      car_model = build(:car_model, manufacture: manufacture)
      allow(car_model).to receive(:manufacture).and_return(manufacture)
      expect(car_model.decorate.manufacture_name).to eq('N/A')
    end
  end
end
