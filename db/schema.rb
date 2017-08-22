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
    t.string   "timestamp",                                               default: ""
    t.decimal  "lat",                           precision: 13, scale: 10, default: "0.0"
    t.decimal  "lon",                           precision: 13, scale: 10, default: "0.0"
    t.integer  "accuracy",                                                default: 0
    t.boolean  "homestead_sprayed",                                       default: false
    t.string   "sprayer_id",                                              default: ""
    t.string   "sprayer_2_id",                                            default: ""
    t.boolean  "ddt_used_1",                                              default: false
    t.integer  "ddt_sprayed_rooms_1",                                     default: 0
    t.integer  "ddt_sprayed_shelters_1",                                  default: 0
    t.boolean  "ddt_refill_1",                                            default: false
    t.boolean  "pyrethroid_used_1",                                       default: false
    t.integer  "pyrethroid_sprayed_rooms_1",                              default: 0
    t.integer  "pyrethroid_sprayed_shelters_1",                           default: 0
    t.boolean  "pyrethroid_refill_1",                                     default: false
    t.boolean  "ddt_used_2",                                              default: false
    t.integer  "ddt_sprayed_rooms_2",                                     default: 0
    t.integer  "ddt_sprayed_shelters_2",                                  default: 0
    t.integer  "ddt_refill_2",                                            default: 0
    t.boolean  "pyrethroid_used_2",                                       default: false
    t.integer  "pyrethroid_sprayed_rooms_2",                              default: 0
    t.integer  "pyrethroid_sprayed_shelters_2",                           default: 0
    t.boolean  "pyrethroid_refill_2",                                     default: false
    t.integer  "unsprayed_rooms",                                         default: 0
    t.integer  "unsprayed_shelters",                                      default: 0
    t.string   "foreman",                                                 default: ""
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
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
