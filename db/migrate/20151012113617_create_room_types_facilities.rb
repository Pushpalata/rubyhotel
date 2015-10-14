class CreateRoomTypesFacilities < ActiveRecord::Migration
  def change
    create_table :room_types_facilities do |t|
      t.integer :room_type_id
      t.integer :facility_id

      t.timestamps
    end
  end
end
