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

ActiveRecord::Schema.define(version: 2020_10_14_005640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pets", force: :cascade do |t|
    t.string "img"
    t.string "name"
    t.string "approximate_age"
    t.string "sex"
    t.string "description"
    t.string "adoptable"
    t.bigint "shelter_id"
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.integer "rating"
    t.text "content"
    t.string "picture"
    t.bigint "user_id"
    t.bigint "shelter_id"
    t.string "user_name"
    t.index ["shelter_id"], name: "index_reviews_on_shelter_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
  end

  add_foreign_key "pets", "shelters"
  add_foreign_key "reviews", "shelters"
  add_foreign_key "reviews", "users"
end
