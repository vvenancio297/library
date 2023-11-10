# frozen_string_literal: true

module BookReservation
  class Update
    def initialize(reservation, status)
      @reservation = reservation
      @status = status
    end

    def run
      new_status = status.blank? ? status : Reservation.statuses.key(status.to_i)
      reservation.update(status: new_status)

      reservation
    end

    private

    attr_reader :reservation, :status
  end
end
