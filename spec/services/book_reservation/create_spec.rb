# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookReservation::Create do
  describe '#run' do
    let(:member) { create(:user, :admin) }
    let(:service) { described_class.new(book_id, member, pickup_time) }

    context 'when there are no errors' do
      let(:pickup_time) { nil }
      let(:book_id) { nil }
      
      it 'returns reservations with errors' do
        reservation = service.run

        expect(reservation.persisted?).to eq(false)
        expect(reservation.errors).to be_present
      end
    end

    context 'when there are not errors' do
      let(:pickup_time) { Time.zone.now }
      let(:book_id) { create(:book).id }

      it 'returns reservation without errors' do
        reservation = service.run

        expect(reservation.persisted?).to eq(true)
        expect(reservation.errors).not_to be_present
      end
    end
  end
end