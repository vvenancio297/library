# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book, :user, :status, :pickup_time, presence: true

  enum status: { returned: 0, lent: 1 }

  before_save :validate_pickup_time
  before_save :generate_reservation_number

  private

  def validate_pickup_time
    errors.add(:pickup_time, "") if pickup_time < Time.zone.today
  end

  def generate_reservation_number
    
  end
end
