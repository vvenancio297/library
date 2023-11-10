class RemoveNumberFromReservation < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :number
  end
end
