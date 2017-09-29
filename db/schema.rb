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

ActiveRecord::Schema.define(version: 20170928090348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisements", force: :cascade do |t|
    t.string "name"
    t.string "banner"
    t.boolean "active"
    t.string "for_page"
    t.string "lat"
    t.string "long"
    t.string "address"
    t.string "phone"
    t.string "web_site"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_advertisements_on_deleted_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "claimed_rewards", force: :cascade do |t|
    t.string "status", default: "submitted"
    t.bigint "customer_id"
    t.bigint "reward_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "managed_by_id"
    t.string "qr_token"
    t.boolean "given", default: false
    t.index ["customer_id"], name: "index_claimed_rewards_on_customer_id"
    t.index ["managed_by_id"], name: "index_claimed_rewards_on_managed_by_id"
    t.index ["reward_id"], name: "index_claimed_rewards_on_reward_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "logo"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "partner", default: false
    t.index ["category_id"], name: "index_companies_on_category_id"
    t.index ["deleted_at"], name: "index_companies_on_deleted_at"
  end

  create_table "contact_forms", force: :cascade do |t|
    t.string "subject"
    t.text "message"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["customer_id"], name: "index_contact_forms_on_customer_id"
    t.index ["deleted_at"], name: "index_contact_forms_on_deleted_at"
  end

  create_table "customer_chat_support_data", force: :cascade do |t|
    t.text "text"
    t.string "supportable_type"
    t.bigint "supportable_id"
    t.bigint "customer_chat_support_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_chat_support_id"], name: "index_customer_chat_support_data_on_customer_chat_support_id"
    t.index ["supportable_type", "supportable_id"], name: "index_customer_chat_support_supportable"
  end

  create_table "customer_chat_supports", force: :cascade do |t|
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_chat_supports_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "provider", default: "phone", null: false
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
    t.string "language"
    t.float "lat"
    t.float "long"
    t.string "verification_code"
    t.datetime "verification_expired_at"
    t.datetime "verified_at"
    t.string "login_digit"
    t.datetime "digit_expired_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "update_location_at"
    t.index ["confirmation_token"], name: "index_customers_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_customers_on_deleted_at"
    t.index ["digit_expired_at"], name: "index_customers_on_digit_expired_at"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["login_digit"], name: "index_customers_on_login_digit"
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_customers_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_customers_on_unlock_token", unique: true
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_id"
    t.string "deviceable_type"
    t.bigint "deviceable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deviceable_type", "deviceable_id"], name: "index_devices_on_deviceable_type_and_deviceable_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_faqs_on_deleted_at"
  end

  create_table "guides", force: :cascade do |t|
    t.string "title"
    t.string "youtube_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_guides_on_deleted_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchant_chat_support_data", force: :cascade do |t|
    t.text "text"
    t.string "supportable_type"
    t.bigint "supportable_id"
    t.bigint "merchant_chat_support_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_chat_support_id"], name: "index_merchant_chat_support_data_on_merchant_chat_support_id"
    t.index ["supportable_type", "supportable_id"], name: "index_merchant_chat_support_supportable"
  end

  create_table "merchant_chat_supports", force: :cascade do |t|
    t.bigint "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_merchant_chat_supports_on_merchant_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "provider", default: "phone", null: false
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
    t.string "phone"
    t.datetime "deleted_at"
    t.json "tokens"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_merchants_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_merchants_on_deleted_at"
    t.index ["email"], name: "index_merchants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_merchants_on_reset_password_token", unique: true
    t.index ["store_id"], name: "index_merchants_on_store_id"
    t.index ["uid", "provider"], name: "index_merchants_on_uid_and_provider", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.string "notification_type"
    t.string "text"
    t.string "notifyable_type"
    t.bigint "notifyable_id"
    t.string "objectable_type"
    t.bigint "objectable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifyable_type", "notifyable_id"], name: "index_notifications_on_notifyable_type_and_notifyable_id"
    t.index ["objectable_type", "objectable_id"], name: "index_notifications_on_objectable_type_and_objectable_id"
  end

  create_table "operating_systems", force: :cascade do |t|
    t.string "name"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_operating_systems_on_customer_id"
  end

  create_table "privacy_policies", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.text "body"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_promotions_on_deleted_at"
  end

  create_table "receipts", force: :cascade do |t|
    t.string "receipt_id"
    t.float "total"
    t.string "capture"
    t.integer "earned_points"
    t.string "status", default: "submitted"
    t.bigint "store_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "managed_by_id"
    t.index ["customer_id"], name: "index_receipts_on_customer_id"
    t.index ["deleted_at"], name: "index_receipts_on_deleted_at"
    t.index ["managed_by_id"], name: "index_receipts_on_managed_by_id"
    t.index ["store_id"], name: "index_receipts_on_store_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.integer "require_points"
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "approved_claimed_rewards_count", default: 0
    t.bigint "store_id"
    t.float "price"
    t.index ["deleted_at"], name: "index_rewards_on_deleted_at"
    t.index ["store_id"], name: "index_rewards_on_store_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.string "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
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
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "avatar"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "role", default: "Admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pending_notifications_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_ads", force: :cascade do |t|
    t.string "title"
    t.string "video"
    t.date "start_date"
    t.date "end_date"
    t.integer "earned_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_video_ads_on_deleted_at"
  end

  add_foreign_key "claimed_rewards", "customers"
  add_foreign_key "claimed_rewards", "rewards"
  add_foreign_key "companies", "categories"
  add_foreign_key "contact_forms", "customers"
  add_foreign_key "customer_chat_support_data", "customer_chat_supports"
  add_foreign_key "customer_chat_supports", "customers"
  add_foreign_key "merchant_chat_support_data", "merchant_chat_supports"
  add_foreign_key "merchant_chat_supports", "merchants"
  add_foreign_key "operating_systems", "customers"
  add_foreign_key "receipts", "customers"
  add_foreign_key "receipts", "stores"
  add_foreign_key "rewards", "stores"
  add_foreign_key "stickers", "sticker_groups"
  add_foreign_key "stores", "companies"
  add_foreign_key "stores", "locations"
end
