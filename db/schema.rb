# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151013111757) do

  create_table "bookings", force: true do |t|
    t.string   "uid"
    t.date     "checkin_date"
    t.date     "checkout_date"
    t.integer  "room_type_id"
    t.integer  "room_count"
    t.integer  "night_count"
    t.integer  "adult_count"
    t.integer  "child_count"
    t.string   "name_title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_no"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "country"
    t.string   "state"
    t.string   "zipcode"
    t.string   "status"
    t.float    "payment_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilities", force: true do |t|
    t.string   "name"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_bookings", force: true do |t|
    t.integer  "room_id"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_types", force: true do |t|
    t.string   "name"
    t.float    "rate"
    t.string   "room_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_types_facilities", force: true do |t|
    t.integer  "room_type_id"
    t.integer  "facility_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.string   "room_no"
    t.string   "wing"
    t.float    "rate"
    t.string   "floor_no"
    t.integer  "room_type_id"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
