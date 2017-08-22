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

ActiveRecord::Schema.define(version: 20170720001154) do

  create_table "spray_data", force: :cascade do |t|
    t.string   "timeStamp",                                            default: ""
    t.decimal  "lat",                        precision: 13, scale: 10, default: "0.0"
    t.decimal  "lon",                        precision: 13, scale: 10, default: "0.0"
    t.integer  "accuracy",                                             default: 0
    t.boolean  "homesteadSprayed",                                     default: false
    t.string   "sprayerID",                                            default: ""
    t.string   "sprayer2ID",                                           default: ""
    t.boolean  "DDTUsed1",                                             default: false
    t.integer  "DDTSprayedRooms1",                                     default: 0
    t.integer  "DDTSprayedShelters1",                                  default: 0
    t.boolean  "DDTRefill1",                                           default: false
    t.boolean  "pyrethroidUsed1",                                      default: false
    t.integer  "pyrethroidSprayedRooms1",                              default: 0
    t.integer  "pyrethroidSprayedShelters1",                           default: 0
    t.boolean  "pyrethroidRefill1",                                    default: false
    t.boolean  "DDTUsed2",                                             default: false
    t.integer  "DDTSprayedRooms2",                                     default: 0
    t.integer  "DDTSprayedShelters2",                                  default: 0
    t.integer  "DDTRefill2",                                           default: 0
    t.boolean  "pyrethroidUsed2",                                      default: false
    t.integer  "pyrethroidSprayedRooms2",                              default: 0
    t.integer  "pyrethroidSprayedShelters2",                           default: 0
    t.boolean  "pyrethroidRefill2",                                    default: false
    t.integer  "unsprayedRooms",                                       default: 0
    t.integer  "unsprayedShelters",                                    default: 0
    t.string   "foreman",                                              default: ""
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "profile_img"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
