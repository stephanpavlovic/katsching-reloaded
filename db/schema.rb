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

ActiveRecord::Schema[7.0].define(version: 2023_02_25_122622) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "repetitions", force: :cascade do |t|
    t.string "timing"
    t.boolean "active", default: true
    t.datetime "next_iteration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_repetitions_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "amount_cents"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.string "name"
    t.string "category"
    t.boolean "shared", default: false
    t.bigint "repetition_id"
    t.index ["category"], name: "index_transactions_on_category"
    t.index ["name"], name: "index_transactions_on_name"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "crypted_password"
    t.string "salt"
    t.string "magic_login_token"
    t.datetime "magic_login_token_expires_at"
    t.datetime "magic_login_email_sent_at"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["magic_login_token"], name: "index_users_on_magic_login_token"
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
  end

  add_foreign_key "repetitions", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "groups"
end
