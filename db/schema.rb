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

ActiveRecord::Schema[8.1].define(version: 2026_09_19_133224) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["account_id", "email"], name: "index_contacts_on_account_id_and_email", unique: true
    t.index ["account_id"], name: "index_contacts_on_account_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.integer "kind", default: 0, null: false
    t.bigint "ticket_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["ticket_id", "created_at"], name: "index_messages_on_ticket_id_and_created_at"
    t.index ["ticket_id"], name: "index_messages_on_ticket_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "assignee_id"
    t.datetime "created_at", null: false
    t.integer "priority", default: 1, null: false
    t.bigint "requester_id"
    t.integer "status", default: 0, null: false
    t.string "subject", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_tickets_on_account_id"
    t.index ["assignee_id"], name: "index_tickets_on_assignee_id"
    t.index ["requester_id"], name: "index_tickets_on_requester_id"
    t.index ["status"], name: "index_tickets_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "contacts", "accounts"
  add_foreign_key "messages", "tickets"
  add_foreign_key "messages", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "tickets", "accounts"
  add_foreign_key "tickets", "contacts", column: "requester_id"
  add_foreign_key "tickets", "users", column: "assignee_id"
  add_foreign_key "users", "accounts"
end
