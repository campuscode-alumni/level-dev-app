# frozen_string_literal: true

require 'rails_helper'

describe RentalPresenter do
  describe '#status' do
    let(:user) { create(:user) }
    it 'should render blue when scheduled' do
      rental = build(:rental, status: :scheduled)
      result = RentalPresenter.new(rental, user).status
      expect(result).to eq('<span class="badge bg-primary">agendada</span>')
    end

    it 'should render yellow when ongoing' do
      rental = build(:rental, status: :ongoing)
      result = RentalPresenter.new(rental, user).status
      expect(result).to eq('<span class="badge bg-warning">em andamento</span>')
    end

    it 'should render green when finalized' do
      rental = build(:rental, status: :finalized)
      result = RentalPresenter.new(rental, user).status
      expect(result).to eq('<span class="badge bg-success">finalizada</span>')
    end

    it 'should render blue when status not found' do
      rental = build(:rental, status: nil)
      result = RentalPresenter.new(rental, user).status
      expect(result).to eq('<span class="badge bg-primary">Status não existe</span>')
    end
  end
end
