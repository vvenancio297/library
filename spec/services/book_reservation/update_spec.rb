# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookReservation::Update do
  describe '#run' do
    let!(:reservation) { create(:reservation, status: "reserved") }
    let(:service) { described_class.new(reservation, status) }

    context 'when there are no errors' do
      let(:status) { nil }
      
      it 'returns reservations with errors' do
        reserv = service.run

        expect(reservation.status).to eq(reserv.status)
        expect(reserv.errors).to be_present
      end
    end

    context 'when there are not errors' do
      let(:status) { Reservation.statuses[:lent].to_s }

      it 'returns reservation without errors' do
        old_status = reservation.status
        reserv = service.run

        expect(old_status).not_to eq(reserv.status)
        expect(reserv.errors).not_to be_present
      end
    end
  end
end
