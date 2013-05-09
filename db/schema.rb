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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130509040507) do

  create_table "annoucements", :force => true do |t|
    t.text    "body"
    t.integer "party_id"
  end

  add_index "annoucements", ["party_id"], :name => "index_annoucements_on_party_id"

  create_table "charities", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "category"
    t.string "website"
    t.string "number"
    t.string "donation_url"
  end

  create_table "comments", :force => true do |t|
    t.datetime "date"
    t.string   "name"
    t.text     "body"
    t.integer  "party_id"
  end

  add_index "comments", ["party_id"], :name => "index_comments_on_party_id"

  create_table "guests", :force => true do |t|
    t.string  "name"
    t.string  "email"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "address"
    t.boolean "rsvp"
    t.float   "donation"
    t.integer "party_id"
    t.boolean "invite_sent",        :default => true
    t.boolean "anonymous_donation"
  end

  add_index "guests", ["party_id"], :name => "index_guests_on_party_id"

  create_table "messages", :force => true do |t|
    t.string  "name"
    t.string  "email"
    t.text    "body"
    t.boolean "sent",                  :default => false
    t.boolean "is_charity_suggestion"
  end

  create_table "parties", :force => true do |t|
    t.string  "name"
    t.string  "host"
    t.string  "party_type"
    t.string  "location"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "address"
    t.string  "phone_number"
    t.date    "date"
    t.time    "time"
    t.text    "message"
    t.integer "charity_id"
    t.integer "user_id"
    t.float   "goal"
    t.time    "end_time"
  end

  add_index "parties", ["user_id"], :name => "index_parties_on_user_id"

  create_table "profiles", :force => true do |t|
    t.string  "username"
    t.string  "name"
    t.text    "zipcode"
    t.integer "user_id"
  end

  add_index "profiles", ["username"], :name => "index_profiles_on_username", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "token_secret"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
