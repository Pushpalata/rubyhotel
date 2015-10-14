class CreateRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_types do |t|
      t.string :name
      t.float :rate
      t.string :room_count

      t.timestamps
    end
  end
end
