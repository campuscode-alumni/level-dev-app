require 'rails_helper'

describe RentalPresenter do
  describe '#status' do
    it 'should render blue when scheduled' do
      rental = build(:rental, status: :scheduled)
      result = RentalPresenter.new(rental).status
      RentalPresenter.new(rental).client
      expect(result).to eq('<span class="badge bg-primary">agendada</span>')
    end

    it 'should render yellow when ongoing' do
      rental = build(:rental, status: :ongoing)
      result = RentalPresenter.new(rental).status
      expect(result).to eq('<span class="badge bg-warning">em andamento</span>')
    end

    it 'should render green when finalized' do
      rental = build(:rental, status: :finalized)
      result = RentalPresenter.new(rental).status
      expect(result).to eq('<span class="badge bg-success">finalizada</span>')
    end

    xit 'should render blue when status not found' do
      result = helper.status('default')
      expect(result).to eq('<span class="badge bg-primary">Status não existe</span>')
    end

    xit 'should render blue when status not found' do
      result = helper.status(nil)
      expect(result).to eq('<span class="badge bg-primary">Status não existe</span>')
    end
  end
end
