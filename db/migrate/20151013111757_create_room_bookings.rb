class CreateRoomBookings < ActiveRecord::Migration
  def change
    create_table :room_bookings do |t|
      t.integer :room_id
      t.integer :booking_id

      t.timestamps
    end
  end
end
