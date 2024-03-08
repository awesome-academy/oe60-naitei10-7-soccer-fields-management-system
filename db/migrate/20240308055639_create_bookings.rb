class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.integer :booking_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :field_type, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bookings, :booking_id
  end
end
