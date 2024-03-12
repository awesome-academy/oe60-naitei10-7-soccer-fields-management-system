class AddBookedDateToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :booked_date, :date
  end
end
