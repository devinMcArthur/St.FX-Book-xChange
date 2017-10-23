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

ActiveRecord::Schema.define(version: 20171022200948) do

  create_table "books", force: :cascade do |t|
    t.text     "title"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "visible",      default: true
    t.string   "asking_price"
    t.index ["user_id", "created_at"], name: "index_books_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "book_id"
    t.string   "negotiated_price"
    t.boolean  "previous_trade",   default: false
  end

  create_table "demands", force: :cascade do |t|
    t.text     "title"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "temporary",  default: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "demand_id"
    t.integer  "book_id"
    t.integer  "weight"
    t.integer  "prev_match"
    t.integer  "streak"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "user_id"
    t.integer "conversation_id"
    t.integer "message_id"
    t.boolean "read",            default: false
    t.index ["conversation_id"], name: "index_notifications_on_conversation_id"
    t.index ["sender_id"], name: "index_notifications_on_sender_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_digest"], name: "index_users_on_remember_digest"
  end

end
