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

ActiveRecord::Schema.define(version: 2019_03_03_051304) do

  create_table "absentee_requests", force: :cascade do |t|
    t.string "street_number"
    t.string "street_name"
    t.string "street_unit"
    t.string "city"
    t.string "postal_code"
    t.string "email"
    t.string "gender"
    t.boolean "do_not_share_permanent"
    t.boolean "do_not_share_national"
    t.boolean "do_not_share_municipal"
    t.date "left_ontario"
    t.date "intened_return_ontario"
    t.boolean "intened_to_return"
    t.boolean "example_two_year_limit_military"
    t.boolean "example_two_year_limit_government"
    t.boolean "example_two_year_limit_student"
    t.boolean "example_two_year_limit_family"
    t.string "delivery_option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "mailing_street_number"
    t.string "mailing_street_name"
    t.string "mailing_street_unit"
    t.string "mailing_city"
    t.string "mailing_postal_code"
    t.integer "step_number"
    t.string "exempt_reason"
    t.boolean "submitted"
    t.boolean "approved"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string "notification_type"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read"
    t.time "read_at"
    t.boolean "delivered"
    t.time "delivered_at"
    t.string "delivery_receipt"
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
    t.string "phone"
    t.boolean "confirmed_registration"
    t.string "global_preference"
    t.boolean "global_receive_email"
    t.boolean "registration_submitted"
    t.boolean "upcoming_election_notifications"
    t.boolean "upcoming_election_options_notifications"
    t.boolean "day_before_election_notifications"
    t.boolean "election_day_notifications"
    t.boolean "election_results_notifications"
    t.boolean "advance_voting_open_notifications"
    t.boolean "advance_voting_last_day_notifications"
    t.boolean "advance_voting_closed_notifications"
    t.boolean "by_mail_application_open_notifications"
    t.boolean "by_mail_application_reminder_notifications"
    t.string "by_mail_application_reminder_notification_options"
    t.boolean "special_ballot_voting_open_notifications"
    t.boolean "special_ballot_voting_remdiner_notifications"
    t.string "special_ballot_voting_remdiner_notification_options"
    t.boolean "special_ballot_voting_closed_notifications"
    t.boolean "registration_deadline_notifications"
    t.string "registration_deadline_notification_options"
    t.boolean "reregistration_deadline_notifications"
    t.string "reregistration_deadline_notification_options"
    t.boolean "registration_approved_notifications"
    t.boolean "by_mail_ballot_notifications"
    t.boolean "online_special_ballot_available_notifications"
    t.boolean "sample_ballot_available_notifications"
    t.boolean "dvic_available_notifications"
    t.boolean "by_mail_application_deadline_notifications"
    t.string "by_mail_application_deadline_notification_options"
    t.boolean "by_mail_submission_deadline_notifications"
    t.string "by_mail_submission_deadline_notification_options"
    t.string "middle_name"
    t.boolean "is_special_ballot"
    t.boolean "is_special_ballot_approved"
    t.boolean "is_special_ballot_pending"
    t.boolean "is_registration_deadline_passed"
    t.string "needs_reregistration"
    t.boolean "reregistration_submitted"
    t.boolean "is_reregistered"
    t.boolean "dvic_retrieved"
    t.string "sample_ballot_selection"
    t.string "online_ballot_selection"
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
    t.string "mailing_address"
    t.string "mailing_place"
    t.string "mailing_province"
    t.string "mailing_postal_code"
    t.string "middle_name"
    t.boolean "is_special_ballot"
  end

end
