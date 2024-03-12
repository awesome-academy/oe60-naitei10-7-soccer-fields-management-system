class ChangeDataTypeOfStartAndEndTimeInBookings < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :start_time, :string
    change_column :bookings, :end_time, :string
  end
end
