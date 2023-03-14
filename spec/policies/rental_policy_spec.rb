# frozen_string_literal: true

require 'rails_helper'

describe RentalPolicy do
  describe '#allowed?' do
    it 'should be true if admin' do
      user   = build(:user, :admin)
      rental = build(:rental)
      expect(RentalPolicy.new(user, rental)).to be_allowed
    end

    it 'should be true if employee from subsidiary' do
      subsidiary = build(:subsidiary)
      user       = build(:user, subsidiary: subsidiary)
      rental     = build(:rental, subsidiary: subsidiary)
      expect(RentalPolicy.new(user, rental)).to be_allowed
    end

    it 'should be false if not employee or admin' do
      user   = build(:user)
      rental = build(:rental)
      expect(RentalPolicy.new(user, rental)).to_not be_allowed
    end

    it 'should be false with NilUser' do
      user   = NilUser.new
      rental = build(:rental)
      expect(RentalPolicy.new(user, rental)).to_not be_allowed
    end
  end
end
