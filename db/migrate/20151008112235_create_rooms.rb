class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :room_no
      t.string :wing
      t.float :rate
      t.string :floor_no
      t.integer :room_type_id
      t.boolean :status

      t.timestamps
    end
  end
end
