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

ActiveRecord::Schema.define(version: 20120512222955) do

  create_table "games", force: true do |t|
    t.integer "player2_id"
    t.integer "player1_id"
    t.integer "winner_id"
    t.integer "loser_id"
    t.timestamps
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "content"
  end

  add_index "pages", ["title"], name: "index_pages_on_title"


  create_table "tokens", force: true do |t|
    t.string  "hashed_access_token",  null: false
    t.string  "hashed_refresh_token", null: false
    t.date    "expires_on",           null: false
    t.date    "refresh_by",           null: false
    t.integer "user_id",              null: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              default: false
    t.string   "fb_user_id"
    t.boolean  "activated",          default: false
    t.boolean  "recover_password",   default: false
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["fb_user_id"], name: "index_users_on_fb_user_id"

end
