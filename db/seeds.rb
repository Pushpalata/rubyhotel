# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
["King Size Bed", "Queen Size Bed", "Pool Facing", "Gym"].each do |facility|
  Facility.create(:name => facility)    
end

[["Deluxe", 7000, ["Queen Size Bed"]], ["Luxury", 8500, ["Queen Size Bed", "Pool Facing"]], ["Luxury Suite", 12000, ["King Size Bed", "Pool Facing"]], ["Presidential Suite", 20000, ["King Size Bed", "Pool Facing", "Gym"]]].each do |room_type, rate, facilities|
  rt = RoomType.create(:name => room_type, :rate => rate)    
  facilities.each do |facility|
    rt.facilities << Facility.where(:name => facility).first
  end
end
[["Deluxe", ("A".."D").to_a, (1..5).to_a], ["Luxury", ("A".."D").to_a, (6..10).to_a], ["Luxury Suite", ["D"], (11..20).to_a], ["Luxury Suite", ["E"], [1,2]], ["Presidential Suite", ["E"], (3..10).to_a]].each do |room_type, wings, rooms|
  rt = RoomType.where(:name => room_type).first
  if rt.present?
    wings.each do |wing|
      rooms.each do |room_no|
        rt.rooms << Room.create(:room_no => room_no, :wing => wing)
      end
    end
  end
end



