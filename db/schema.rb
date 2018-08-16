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

ActiveRecord::Schema.define(version: 20170713004004) do

  create_table "allowed_emails", force: :cascade do |t|
    t.string "email"
  end

  create_table "spray_data", force: :cascade do |t|
    t.string  "imei",                                         default: ""
    t.string  "timestamp",                                    default: ""
    t.decimal "lat",                precision: 13, scale: 10, default: "0.0"
    t.decimal "lon",                precision: 13, scale: 10, default: "0.0"
    t.integer "gps_accuracy",                                 default: 0
    t.boolean "homestead_sprayed",                            default: false
    t.boolean "is_mopup_spray",                               default: false
    t.string  "foreman",                                      default: ""
    t.string  "sprayers"
    t.string  "chemical_used",                                default: ""
    t.integer "unsprayed_rooms",                              default: 0
    t.integer "unsprayed_shelters",                           default: 0
    t.string  "stats"
  end

  create_table "users", force: :cascade do |t|
    t.string  "provider"
    t.string  "uid"
    t.string  "name"
    t.string  "email"
    t.string  "profile_img"
    t.boolean "admin",       default: false
  end

  create_table "workers", force: :cascade do |t|
    t.integer  "worker_id"
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
