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

ActiveRecord::Schema.define(version: 20141007172117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beers", force: true do |t|
    t.string   "name",       null: false
    t.integer  "brewer_id",  null: false
    t.float    "abv"
    t.integer  "style_id"
    t.integer  "beer_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beers", ["brewer_id"], name: "index_beers_on_brewer_id", using: :btree
  add_index "beers", ["style_id"], name: "index_beers_on_style_id", using: :btree

  create_table "brewers", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "brewer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dictionaries", force: true do |t|
    t.json     "payload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "beer_id",    null: false
    t.float    "taste",      null: false
    t.text     "text"
    t.float    "appearance"
    t.float    "aroma"
    t.float    "palate"
    t.float    "overall"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["beer_id"], name: "index_reviews_on_beer_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "styles", force: true do |t|
    t.string   "style"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "profile_name",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["profile_name"], name: "index_users_on_profile_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
