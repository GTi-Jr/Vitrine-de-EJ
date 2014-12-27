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

ActiveRecord::Schema.define(version: 20141227082622) do

  create_table "junior_enterprises", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "logo"
    t.text     "description"
    t.text     "phrase"
    t.string   "site"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "youtube"
    t.string   "facebook"
    t.string   "course"
    t.string   "area"
    t.string   "address"
    t.boolean  "consultor"
    t.boolean  "product"
    t.integer  "access"
    t.boolean  "project"
    t.boolean  "training"
    t.boolean  "seal"
  end

  add_index "junior_enterprises", ["user_id"], name: "index_junior_enterprises_on_user_id"

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "photo"
    t.string   "position"
    t.integer  "junior_enterprise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "email"
  end

  add_index "members", ["junior_enterprise_id"], name: "index_members_on_junior_enterprise_id"

  create_table "messages", force: true do |t|
    t.text     "text"
    t.string   "email"
    t.string   "phone"
    t.string   "name"
    t.integer  "junior_enterprise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read"
  end

  add_index "messages", ["junior_enterprise_id"], name: "index_messages_on_junior_enterprise_id"

# Could not dump table "users" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
