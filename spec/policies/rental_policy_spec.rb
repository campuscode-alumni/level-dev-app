# frozen_string_literal: true

require 'rails_helper'

describe RentalPolicy do
  describe '#allowed?' do
    subject { RentalPolicy.new(user, rental) }

    context 'true if admin' do
      let(:user) { build(:user, :admin) }
      let(:rental) { build(:rental) }
      it { is_expected.to be_allowed }
    end

    context 'true if employee from subsidiary' do
      let(:subsidiary) { create(:subsidiary) }
      let(:user) { build(:user, subsidiary: subsidiary) }
      let(:rental) { build(:rental, subsidiary: subsidiary) }
      it { is_expected.to be_allowed }
    end

    context 'false if not employee or admin' do
      let(:user) { build(:user) }
      let(:rental) { build(:rental) }
      it { is_expected.to_not be_allowed }
    end

    context 'false if not employee or admin' do
      let(:user) { build(:user, subsidiary: nil) }
      let(:rental) { build(:rental) }
      it { is_expected.to_not be_allowed }
    end
  end
end
