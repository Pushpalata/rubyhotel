class Room < ActiveRecord::Base
  belongs_to :room_type
  has_many :bookings, :through => :room_bookings
  has_many :room_bookings
  validates :room_no, :wing, presence: true
  validates :room_no, uniqueness: {scope: [:wing]}
  scope :open, -> { where("rooms.status is null or rooms.status = ?", true) }
  scope :without_bookings, -> { where('id NOT IN (SELECT DISTINCT(room_id) FROM room_bookings)')}

  after_save :update_room_type
  after_destroy :update_room_type

  def update_room_type
    room_type = self.room_type
    room_type.update_column(:room_count, room_type.room_ids.count) if room_type.present?
  end

  def self.search(params)
    rooms = Room.open
    includes = []
    #for Website search
    if params[:room_type_id].present?
      rooms = rooms.where("rooms.room_type_id = ?", params[:room_type_id])
    end
    #for API search
    if params[:room_type_name].present?
      rooms = rooms.where("room_types.name = ?", params[:room_type_name])
      includes << "room_types"
    end
    if params[:booking_date].present?
      rooms = rooms.where("bookings.checkin_date >= ? and bookings.checkout_date <= ?", params[:booking_date], params[:booking_date])
      includes << "bookings"
    end
    #include aplicable tables
    rooms = rooms.includes(includes) unless includes.empty?
    rooms
  end

end
