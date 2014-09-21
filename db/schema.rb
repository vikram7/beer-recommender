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

ActiveRecord::Schema.define(version: 20140921025135) do

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

  create_table "brewers", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "brewer_id"
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

  create_table "styles", force: true do |t|
    t.string   "style"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "profile_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
