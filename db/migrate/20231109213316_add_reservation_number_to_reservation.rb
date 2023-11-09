class AddReservationNumberToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :resevation_number, :integer
  end
end
