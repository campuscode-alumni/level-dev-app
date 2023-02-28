# frozen_string_literal: true

require 'rails_helper'

describe RentalHelper do
  describe '#status' do
    it 'should render blue when scheduled' do
      rental = build(:rental, status: :scheduled)
      result = helper.status(rental.status)
      expect(result).to eq('<span class="badge bg-primary">agendada</span>')
    end

    it 'should render yellow when ongoing' do
      rental = build(:rental, status: :ongoing)
      result = helper.status(rental.status)
      expect(result).to eq('<span class="badge bg-warning">em andamento</span>')
    end

    it 'should render green when finalized' do
      rental = build(:rental, status: :finalized)
      result = helper.status(rental.status)
      expect(result).to eq('<span class="badge bg-success">finalizada</span>')
    end

    it 'should render blue when status not found' do
      result = helper.status('default')
      expect(result).to eq('<span class="badge bg-primary">Status não existe</span>')
    end

    it 'should render blue when status not found' do
      result = helper.status(nil)
      expect(result).to eq('<span class="badge bg-primary">Status não existe</span>')
    end
  end
end
