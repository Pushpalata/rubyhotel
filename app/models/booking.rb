class Booking < ActiveRecord::Base
  belongs_to :room_type
  has_many :rooms, :through => :room_bookings
  has_many :room_bookings

  scope :active, -> { where("rooms.status = ?", 'Active') }
  scope :canceled, -> { where("rooms.status = ?", 'Canceled') }
  scope :completed, -> { where("rooms.status = ?", 'Completed') }

  validates :uid, :checkin_date, :checkout_date, :room_count, :first_name, 
            :last_name, :email, :phone_no, :address_line1, :address_line2, 
            :city, :state, :country , presence: true
  validates :phone_no,
            :format => { :with => /\A[0-9+() \-]+\z/ }, :allow_blank =>true
  validates :email, 
            :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :uid, uniqueness: true
  validate :check_dates

  before_validation :set_uid, :on => :create
  before_create :assign_rooms
  after_validation :set_night_count, :set_payment_amount
  after_create :send_email_to_user

  def check_dates
    if self.checkin_date.present? and self.checkin_date > Date.today + 6.months
      #Can only book room in 6 month advance
      self.errors.add(:checkin_date, "Checkin Date should be in 6 months period time.")
    end
    if self.checkin_date.present? and self.checkin_date <= Date.today - 1
      #No Booking for Past Days
      self.errors.add(:checkin_date, "Invalid Check In Date")
    end
    if self.checkin_date.present? and self.checkout_date.present? and self.checkin_date > self.checkout_date
      #checkout date should be after checkin date
      self.errors.add(:checkout_date, "Invalid Check Out Date")
    end
  end

  def set_uid
    uid = ""
    # Get Unique String
    loop do
      uid = "B" + rand(2**7...5**25).to_s(20).upcase
      break uid unless Booking.where(uid: uid).first
    end
    self.uid = uid
  end

  def set_night_count
    self.night_count = (self.checkout_date.to_date - self.checkin_date.to_date).to_i
  end

  def set_payment_amount
    self.payment_amount = self.room_type.rate * self.room_count * self.night_count
  end

  def assign_rooms
    #allote rooms to the booking
    allowed_room_ids = self.room_type.room_ids
    if allowed_room_ids.present?
      #rooms present for this room category
      #room which have not been booked
      no_booking_room_ids = Room.without_bookings.where(:room_type_id => self.room_type_id).collect{|r| r.id}
      #rooms available for this Time Interval
      non_conflicting_booking_ids = Booking.where("room_type_id = ? and checkin_date < ? and checkout_date > ?", self.room_type_id, self.checkout_date, self.checkin_date).collect{|b| b.id}
      available_room_ids = RoomBooking.where(:booking_id => non_conflicting_booking_ids).collect{|rb| rb.room_id}
      assignable_room_ids = (no_booking_room_ids + available_room_ids).uniq
      assignable_room_cnt = assignable_room_ids.count
      if self.room_count > assignable_room_cnt
        
        #show error not enough room available
        if assignable_room_cnt == 0
          self.errors.add(:base, "There are no Rooms available for this Category.")
        elsif assignable_room_cnt == 1
          self.errors.add(:base, "Only 1 Room is available for this Category.")
        else
          self.errors.add(:base, "Only #{assignable_room_cnt} Rooms are available for this Category.")
        end
      else
        
        #order by room_no to get sequencial rooms and limit with room_count
        assignable_rooms = Room.where(:id => assignable_room_ids).order(:room_no).limit(self.room_count)
        #assign rooms for current booking
        self.rooms << assignable_rooms
        return true
      end
    else
      
      #show error rooms not available
      self.errors.add(:base, "There are no Rooms available for this Category.")
    end
  end

  def send_email_to_user
    # Send Email on the email address provided in booking details
    # UserMailer method
  end

  def full_address
    add = self.address_line1 + "<br>"
    add += self.address_line2 + "<br>"
    add += self.city + ", " + self.state + "<br>"
    add += self.country
    add
  end
  
end
