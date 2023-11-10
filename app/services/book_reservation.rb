# frozen_string_literal: true

class BookReservation
  def initialize(user, book)
    @user = user
    @book = book
  end

  # TODO: Generate aleatory reservation number
  def reserve
    return false unless book.available?

    reservaton_status = Reservation.statuses[:lent]
    Reservation.create!(user_id: user.id,
                        book_id: book.id,
                        status: reservaton_status)

    true
  rescue => e
    Rails.logger.error e.message

    false
  end

  private
  
  attr_reader :user, :book
end
