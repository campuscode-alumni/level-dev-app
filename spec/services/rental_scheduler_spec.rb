# frozen_string_literal: true

require 'rails_helper'

describe RentalScheduler do
  describe '#call' do
    subject { described_class.call(rental) }
    context 'should schedule a rental' do
      let(:rental) { build(:rental, start_date: 1.day.from_now, end_date: 3.days.from_now) }
      let!(:car) { create(:car, car_model: create(:car_model, category: rental.category)) }

      it do
        is_expected.to be_success
        expect(rental).to be_persisted
        expect(rental).to be_scheduled
        expect(rental.price_projection.to_i).to_not be_zero
      end
    end
  end
end
