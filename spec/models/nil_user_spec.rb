# frozen_string_literal: true

require 'rails_helper'

describe NilUser do
  describe '#admin?' do
    it { is_expected.to_not be_admin }
  end

  describe '#persisted?' do
    it { is_expected.to_not be_persisted }
  end

  describe '#user?' do
    it { is_expected.to_not be_user }
  end

  describe '#!' do
    it { expect(!subject).to be true }
  end

  describe '#subsidiary' do
    it { expect(subject.subsidiary).to be_nil }
  end

  describe '#email' do
    it { expect(subject.subsidiary).to be_nil }
  end
end
