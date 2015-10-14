class RoomType < ActiveRecord::Base
  has_many :facilities, :through => :room_types_facilities
  has_many :room_types_facilities
  has_many :rooms
  validates :name, :rate, presence: true
  validates :name, uniqueness: true

  def self.search(params)
    room_types = RoomType.all
    non_booked_rooms = Room.without_bookings
    non_booked_room_ids = non_booked_rooms.collect{|r| r.id}
    non_booked_room_type_ids = non_booked_rooms.collect{|r| r.room_type_id}
    non_conflicting_booking_ids = Booking.where("checkin_date < ? and checkout_date > ?", params[:booking][:checkout_date], params[:booking][:checkin_date]).collect{|b| b.id}
    available_room_ids = RoomBooking.where(:booking_id => non_conflicting_booking_ids).collect{|rb| rb.room_id}
    room_info = Room.open.where(:id => non_booked_room_ids + available_room_ids).group(:room_type_id).count
    room_types = room_types.where(:id => room_info.keys)
    [room_types, room_info]
  end

  def rooms_available_for_booking
  end
end
