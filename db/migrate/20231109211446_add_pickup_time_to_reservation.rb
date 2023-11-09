class AddPickupTimeToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :pickup_time, :datetime
  end
end
