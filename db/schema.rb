# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_04_192542) do

  create_table "allowed_emails", force: :cascade do |t|
    t.string "email", default: ""
  end

  create_table "future_spray_locations", force: :cascade do |t|
    t.string "report_date", default: ""
    t.string "reporter", default: ""
    t.float "lat", default: 0.0
    t.float "lng", default: 0.0
  end

  create_table "malaria_reports", force: :cascade do |t|
    t.string "report_date", default: ""
    t.string "reporter", default: ""
    t.float "lat", default: 0.0
    t.float "lng", default: 0.0
  end

  create_table "spray_data", force: :cascade do |t|
    t.string "timestamp", default: ""
    t.string "imei", default: ""
    t.string "foreman", default: ""
    t.string "sprayers"
    t.string "chemical_used", default: ""
    t.string "stats"
    t.integer "unsprayed_rooms", default: 0
    t.integer "unsprayed_shelters", default: 0
    t.boolean "is_mopup_spray", default: false
    t.float "lat", default: 0.0
    t.float "lng", default: 0.0
    t.integer "gps_accuracy", default: 0
  end

  create_table "sprayers", force: :cascade do |t|
    t.string "stat_id"
    t.string "refilled"
  end

  create_table "stats", force: :cascade do |t|
    t.string "sprayers"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", default: ""
    t.string "profile_img", default: ""
    t.boolean "admin", default: false
    t.string "user_id", default: ""
  end

  create_table "workers", force: :cascade do |t|
    t.string "worker_id", default: ""
    t.string "name", default: ""
    t.boolean "active", default: true
  end

end
