class CreateReservation < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :reservations, [:book_id, :user_id, :status], unique: true
  end
end
