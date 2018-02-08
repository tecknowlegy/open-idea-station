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

ActiveRecord::Schema.define(version: 20180217063931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "idea_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_categories_on_idea_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "idea_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_comments_on_idea_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "idea_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "idea_id"
    t.integer "category_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_ideas_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.boolean "is_read"
    t.string "action"
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "view_histories", force: :cascade do |t|
    t.datetime "time_viewed"
    t.string "viewer_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "idea_id"
    t.index ["idea_id"], name: "index_view_histories_on_idea_id"
  end

  add_foreign_key "categories", "ideas"
  add_foreign_key "comments", "ideas"
  add_foreign_key "comments", "users"
  add_foreign_key "ideas", "users"
  add_foreign_key "view_histories", "ideas"
end
