class AddAvailabilityToBookings < ActiveRecord::Migration[6.1]
  def change
    add_reference :bookings, :availability, foreign_key: true
    remove_column :bookings, :start_time
    remove_column :bookings, :end_time
  end
end
