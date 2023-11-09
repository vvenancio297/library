# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :author, :genre, :description, presence: true

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
end
