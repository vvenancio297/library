# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    subject { build(:reservation, :lent) }

    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:reservation, :lent) }

    it { is_expected.to validate_presence_of(:book_id) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  describe '#user_email' do
    let(:reservation) { create(:reservation, :lent) }

    it 'returns user email' do
      user = reservation.user
      expect(reservation.user_email).to eq(user.email)
    end
  end

  describe '#book_title' do
    let(:reservation) { create(:reservation, :lent) }

    it 'returns book title' do
      book = reservation.book
      expect(reservation.book_title).to eq(book.title)
    end
  end

  describe '#book_available?' do
    let(:reservation) { create(:reservation, :lent) }

    it 'returns book available' do
      book = reservation.book
      expect(reservation.book_available?).to eq(book.available?)
    end
  end

  describe '.by_code' do
    context 'when code is present' do
      let!(:reservation) { create(:reservation, :reserved, code: code) }
      let(:code) { 'ABCabcs' }

      it 'returns reservations by its code' do
        reservations = Reservation.by_code(code)
        expect(reservations).to eq([reservation])
      end
    end

    context 'when code is not present' do
      let(:code) { nil }

      it 'returns self' do
        reservations = Reservation.by_code(code)
        expect(reservations).to be_empty
      end
    end
  end
end
