# frozen_string_literal: true

class Reservation < ApplicationRecord
  MAX_NUMBER = 10_000

  belongs_to :book
  belongs_to :user

  validates :book_id, :user_id, :status, :pickup_time, :number, presence: true
  validates :book_id, uniqueness: { scope: [:user_id, :status] }

  validate :check_book_availability, on: :update
  validate :check_pickup_time

  enum status: { reserved: 0, lent: 1 }

  before_validation :generate_number

  delegate :email, to: :user, prefix: :user
  delegate :title, to: :book, prefix: :book
  delegate :available?, to: :book, prefix: :book

  scope :by_number, -> (number) do
    return where(number: number) if number.present?
    self
  end

  private

  def check_pickup_time
    if pickup_time < Time.zone.today
      errors.add(:pickup_time, "Pickup time should be greather than today")
    end
  end

  def generate_number
    books_quantity = Book.sum(:quantity) || MAX_NUMBER
    self.number ||= rand(1..books_quantity)
  end

  def check_book_availability
    return if book_available?
    return unless status_changed?

    errors.add(:base, "The book you're trying to lent is no longer available")
  end
end
