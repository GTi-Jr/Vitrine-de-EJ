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

ActiveRecord::Schema.define(version: 20141028190451) do

  create_table "junior_enterprises", force: true do |t|
    t.string   "name"
    t.string   "logo"
    t.text     "description"
    t.text     "phrase"
    t.string   "site"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.integer  "junior_enterprises_id"
    t.string   "name"
    t.string   "photo"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user"
    t.string   "password"
    t.integer  "junior_enterprises_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

end
