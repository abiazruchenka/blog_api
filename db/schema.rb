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

ActiveRecord::Schema.define(version: 20180528074840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_posts", force: :cascade do |t|
    t.string "title", limit: 64, null: false
    t.text "message", null: false
    t.bigint "user_id"
    t.string "author_ip", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "middle_rating", limit: 2
    t.index ["author_ip", "user_id"], name: "index_blog_posts_on_author_ip_and_user_id"
    t.index ["middle_rating"], name: "index_blog_posts_on_middle_rating"
    t.index ["user_id"], name: "index_blog_posts_on_user_id"
  end

  create_table "login_ips", force: :cascade do |t|
    t.string "login", limit: 32, null: false
    t.string "author_ip", null: false
    t.bigint "user_id"
    t.index ["user_id", "author_ip"], name: "index_login_ips_on_user_id_and_author_ip", unique: true
    t.index ["user_id"], name: "index_login_ips_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "blog_post_id"
    t.integer "rating", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_post_id"], name: "index_ratings_on_blog_post_id"
    t.index ["id"], name: "index_ratings_on_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", limit: 32
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_users_on_id"
  end

  add_foreign_key "blog_posts", "users"
  add_foreign_key "login_ips", "users"
  add_foreign_key "ratings", "blog_posts"
end
