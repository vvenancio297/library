# frozen_string_literal: true

module BookReservation
  class Create
    def initialize(book_id, member, pickup_time)
      @book_id = book_id
      @member = member
      @pickup_time = pickup_time
    end

    def run
      reservation = Reservation.new(reservation_attrs)
      reservation.save

      reservation
    end

    private

    attr_reader :book_id, :member, :pickup_time

    def reservation_attrs
      {
        pickup_time: pickup_time,
        book_id: book_id,
        status: Reservation.statuses[:reserved],
        user_id: member.id
      }
    end
  end
end
