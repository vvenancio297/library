class AddCodeToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :code, :string
    add_index :reservations, :code, unique: true
  end
end
