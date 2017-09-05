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

ActiveRecord::Schema.define(version: 20170905085645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "claimed_rewards", force: :cascade do |t|
    t.string "status", default: "submitted"
    t.bigint "user_id"
    t.bigint "reward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "managed_by_id"
    t.index ["managed_by_id"], name: "index_claimed_rewards_on_managed_by_id"
    t.index ["reward_id"], name: "index_claimed_rewards_on_reward_id"
    t.index ["user_id"], name: "index_claimed_rewards_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "point_rate"
    t.string "logo"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "partner", default: false
    t.index ["category_id"], name: "index_companies_on_category_id"
    t.index ["deleted_at"], name: "index_companies_on_deleted_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.string "receipt_id"
    t.float "total"
    t.string "capture"
    t.integer "earned_points"
    t.string "status", default: "submitted"
    t.bigint "store_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "managed_by_id"
    t.index ["deleted_at"], name: "index_receipts_on_deleted_at"
    t.index ["managed_by_id"], name: "index_receipts_on_managed_by_id"
    t.index ["store_id"], name: "index_receipts_on_store_id"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.integer "require_points"
    t.integer "quantity", default: 0
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_rewards_on_company_id"
    t.index ["deleted_at"], name: "index_rewards_on_deleted_at"
  end

  create_table "sticker_groups", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stickers", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.bigint "sticker_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sticker_group_id"], name: "index_stickers_on_sticker_group_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "long"
    t.string "address"
    t.bigint "company_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_stores_on_company_id"
    t.index ["deleted_at"], name: "index_stores_on_deleted_at"
    t.index ["location_id"], name: "index_stores_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "avatar"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "deleted_at"
    t.string "phone"
    t.string "address"
    t.string "gender"
    t.integer "current_points", default: 0
    t.string "role", default: "Customer"
    t.string "language"
    t.float "lat"
    t.float "long"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "claimed_rewards", "rewards"
  add_foreign_key "claimed_rewards", "users"
  add_foreign_key "companies", "categories"
  add_foreign_key "receipts", "stores"
  add_foreign_key "receipts", "users"
  add_foreign_key "rewards", "companies"
  add_foreign_key "stickers", "sticker_groups"
  add_foreign_key "stores", "companies"
  add_foreign_key "stores", "locations"
end
