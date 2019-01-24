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

ActiveRecord::Schema.define(version: 2019_01_24_162210) do

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string "notification_type"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "first_name"
    t.text "last_name"
    t.integer "dob_day"
    t.integer "dob_month"
    t.integer "dob_year"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.text "postal_code"
    t.string "record_locator"
    t.string "registration_id"
    t.string "demo_id"
    t.boolean "is_registered"
    t.boolean "is_absentee"
    t.boolean "is_vote_by_mail"
    t.string "registration_deadline_notifications"
    t.string "reregistration_deadline_notifications"
    t.string "change_detected_notifications"
    t.string "upcoming_election_notifications"
    t.string "election_change_notificatinos"
    t.string "election_day_notifications"
    t.string "mailing_notifications"
    t.string "ballot_notifications"
    t.string "phone"
    t.boolean "confirmed_registration"
    t.index ["email"], name: "index_users_on_email"
    t.index ["first_name", "last_name", "dob_day", "dob_month", "dob_year", "postal_code"], name: "index_uses_on_identifiers"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "voter_records", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "first_name"
    t.text "last_name"
    t.date "dob"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.text "postal_code"
    t.string "record_locator"
    t.string "registration_id"
    t.string "demo_id"
    t.boolean "is_absentee"
    t.boolean "is_vote_by_mail"
  end

end
