class RemoveIndexFromReservation < ActiveRecord::Migration[7.1]
  def change
    remove_index :reservations, name: 'index_reservations_on_book_id_and_user_id_and_status'
  end
end
