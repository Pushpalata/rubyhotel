class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :uid
      t.date :checkin_date
      t.date :checkout_date
      t.integer :room_type_id
      t.integer :room_count
      t.integer :night_count
      t.integer :adult_count
      t.integer :child_count
      t.string :name_title
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_no
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :country
      t.string :state
      t.string :zipcode
      t.string :status
      t.float :payment_amount

      t.timestamps
    end
  end
end
