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

ActiveRecord::Schema.define(version: 20131122024745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "urls", force: true do |t|
    t.string   "full"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "urls", ["slug"], name: "index_urls_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "visit_logs", force: true do |t|
    t.integer  "url_id"
    t.string   "referer"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visit_logs", ["url_id"], name: "index_visit_logs_on_url_id", using: :btree

end
