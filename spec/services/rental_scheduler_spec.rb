# frozen_string_literal: true

require 'rails_helper'

describe RentalScheduler do
  describe '#schedule' do
    subject { described_class.new(rental).call }
    context 'should schedule a rental' do
      let(:rental) do
        build(:rental, start_date: 1.day.from_now, end_date: 3.days.from_now,
                       price_projection: nil, status: nil)
      end

      it do
        is_expected.to be_success
        expect(rental).to be_persisted
        expect(rental).to be_scheduled
        expect(rental.price_projection).to_not be_zero
      end
    end

    context 'should not schedule a rental with errors' do
      let(:rental) do
        build(:rental, start_date: 1.day.from_now, end_date: 3.days.from_now,
                       price_projection: nil, subsidiary: nil, status: nil)
      end

      it do
        is_expected.to be_failure
        expect(rental).to_not be_persisted
        expect(rental).to be_scheduled
      end
    end

    context 'should not schedule a rental with errors' do
      let(:rental) do
        build(:rental, start_date: nil, end_date: 3.days.from_now,
                       price_projection: nil, subsidiary: nil, status: nil)
      end

      it do
        is_expected.to be false
        expect(rental).to_not be_persisted
        expect(rental).to be_scheduled
      end
    end
  end
end
