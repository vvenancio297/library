# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :author, :genre, :description, presence: true

  has_many :reservations

  scope :search, -> (query) do
    if query.present?
      statement = <<-SQL
        LOWER(author) LIKE LOWER(?) OR
        LOWER(title) LIKE LOWER(?) OR
        LOWER(genre) LIKE LOWER(?) OR
        LOWER(description) LIKE LOWER(?)
      SQL

      where(statement, "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    else
      self
    end
  end

  def available?
    available_quantity > 0
  end

  def available_quantity
    lent_status = Reservation.statuses[:lent]
    lent_books_count = reservations.where(status: lent_status).count
    
    quantity - lent_books_count
  end
end
