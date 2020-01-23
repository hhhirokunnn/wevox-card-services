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

ActiveRecord::Schema.define(version: 20200122092959) do

  create_table "cards", force: :cascade do |t|
    t.string   "title",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: :cascade do |t|
    t.boolean  "started",    default: false
    t.boolean  "finished",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "play_cards", force: :cascade do |t|
    t.integer  "game_id",    limit: 4,                          null: false
    t.integer  "player_id",  limit: 4
    t.integer  "card_id",    limit: 4,                          null: false
    t.string   "status",     limit: 11, default: "initialized"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "play_logs", force: :cascade do |t|
    t.integer  "game_id",      limit: 4,                null: false
    t.integer  "player_id",    limit: 4,                null: false
    t.integer  "phase",        limit: 4,   default: 0
    t.string   "hand_cards",   limit: 255, default: ""
    t.string   "thrown_cards", limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: :cascade do |t|
    t.integer  "game_id",    limit: 4, null: false
    t.integer  "user_id",    limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end
