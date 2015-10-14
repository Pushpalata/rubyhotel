class RoomTypesFacility < ActiveRecord::Base
  belongs_to :room_type
  belongs_to :facility
  validates :room_type_id, :facility_id, :presence => true
end
