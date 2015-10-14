class RoomBooking < ActiveRecord::Base
  belongs_to :room
  belongs_to :booking
  #validates :room_id, :booking_id, :presence => true
end
