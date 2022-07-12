# frozen_string_literal: true

require 'rails_helper'

describe CarModelPresenter do
  describe '#car_options_list' do
    subject { described_class.new(car_model).car_options_list }

    context 'returns a collection of ul > li' do
      let(:car_model) { build(:car_model, car_options: 'ar condicionado,4 portas') }
      it { is_expected.to eq('<ul><li>ar condicionado</li><li>4 portas</li></ul>') }
    end

    context 'returns a collection of ul > li' do
      let(:car_model) { build(:car_model, car_options: 'ar condicionado, 4 portas') }
      it { is_expected.to eq('<ul><li>ar condicionado</li><li>4 portas</li></ul>') }
    end

    context 'returns a collection of ul > li' do
      let(:car_model) { build(:car_model, car_options: '4 portas') }
      it { is_expected.to eq('<ul><li>4 portas</li></ul>') }
    end

    context 'returns a collection of ul > li' do
      let(:car_model) { build(:car_model, car_options: nil) }
      it { is_expected.to eq('') }
    end

    context 'returns a collection of ul > li' do
      let(:car_model) { build(:car_model, car_options: '') }
      it { is_expected.to eq('') }
    end
  end
end
