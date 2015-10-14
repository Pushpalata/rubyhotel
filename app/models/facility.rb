class Facility < ActiveRecord::Base
  has_many :room_types, :through => :room_types_facilities
  has_many :room_types_facilities
  validates :name, presence: true
  validates :name, uniqueness: true
end
