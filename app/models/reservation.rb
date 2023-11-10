# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book_id, :user_id, :status, :pickup_time, :code, presence: true

  validate :check_pickup_time

  enum status: { reserved: 0, lent: 1, returned: 2 }

  before_validation :generate_code

  delegate :email, to: :user, prefix: :user
  delegate :title, to: :book, prefix: :book
  delegate :available?, to: :book, prefix: :book

  scope :by_code, -> (code) do
    return where("LOWER(code) LIKE LOWER(?)", "%#{code}%") if code.present?
    self
  end

  private

  def check_pickup_time
    if pickup_time < Time.zone.today
      errors.add(:pickup_time, "Pickup time should be greather than today")
    end
  end

  def generate_code
    self.code ||= SecureRandom.uuid
  end
end
