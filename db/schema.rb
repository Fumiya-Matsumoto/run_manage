# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_13_064933) do

  create_table "objectives", force: :cascade do |t|
    t.integer "user_id"
    t.integer "year"
    t.integer "month"
    t.string "content"
    t.text "todo_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "post_records", force: :cascade do |t|
    t.integer "post_id"
    t.float "time"
    t.float "distance_km"
    t.integer "distance_m"
    t.integer "record_type"
    t.integer "number"
    t.integer "time_hour"
    t.integer "time_minute"
    t.integer "time_second"
    t.integer "pace_minute"
    t.integer "pace_second"
    t.integer "pace_undersecond"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "pace"
    t.float "distance"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.string "practice_timezone"
    t.string "weather"
    t.string "place"
    t.string "kind_of_practice"
    t.string "strength"
    t.integer "user_id"
    t.date "practice_day"
    t.integer "practice_day_year"
    t.integer "practice_day_month"
    t.integer "practice_day_day"
    t.string "practice_day_of_week"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "num"
    t.integer "num_s"
    t.integer "num_r"
    t.float "pace"
    t.float "pace_s"
    t.float "pace_r"
    t.float "time"
    t.float "time_s"
    t.float "time_r"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "ingredient_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer "user_id"
    t.string "objective"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "recipe_ingredients", "recipes"
end
