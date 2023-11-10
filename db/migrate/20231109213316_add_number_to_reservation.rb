class AddNumberToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :number, :integer
  end
end
