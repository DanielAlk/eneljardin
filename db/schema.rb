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

ActiveRecord::Schema.define(version: 20161019063605) do

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "text",             limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.integer  "role",             limit: 4,     default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.integer  "workshop_id",        limit: 4
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.string   "video_url",          limit: 255
    t.decimal  "price",                            precision: 8, scale: 2
    t.integer  "level",              limit: 4,                             default: 0
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.text     "vimeo",              limit: 65535
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  add_index "movies", ["workshop_id"], name: "index_movies_on_workshop_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer  "workshop_id",        limit: 4
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "note_file_name",     limit: 255
    t.string   "note_content_type",  limit: 255
    t.integer  "note_file_size",     limit: 4
    t.datetime "note_updated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "notes", ["workshop_id"], name: "index_notes_on_workshop_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workshops", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.text     "information",        limit: 65535
    t.integer  "level",              limit: 4
    t.decimal  "price",                            precision: 8, scale: 2
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "movies", "workshops"
  add_foreign_key "notes", "workshops"
end
