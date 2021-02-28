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

ActiveRecord::Schema.define(version: 2021_02_28_042108) do

  create_table "budgets", force: :cascade do |t|
    t.integer "rent"
    t.integer "food"
    t.integer "life"
    t.integer "enjoy"
    t.integer "month_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["month_id"], name: "index_budgets_on_month_id"
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "corrects", force: :cascade do |t|
    t.string "name"
    t.string "player"
    t.integer "amount"
    t.integer "rate"
    t.integer "user_id", null: false
    t.integer "month_id", null: false
    t.integer "deposit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "correct_amount"
    t.index ["deposit_id"], name: "index_corrects_on_deposit_id"
    t.index ["month_id"], name: "index_corrects_on_month_id"
    t.index ["user_id"], name: "index_corrects_on_user_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.integer "total_deposit"
    t.integer "man_salary"
    t.integer "woman_salary"
    t.integer "user_id", null: false
    t.integer "month_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["month_id"], name: "index_deposits_on_month_id"
    t.index ["user_id"], name: "index_deposits_on_user_id"
  end

  create_table "details", force: :cascade do |t|
    t.date "date"
    t.integer "classification"
    t.integer "income"
    t.integer "spending"
    t.string "replayer"
    t.integer "status"
    t.string "note"
    t.integer "month_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["month_id"], name: "index_details_on_month_id"
    t.index ["user_id"], name: "index_details_on_user_id"
  end

  create_table "months", force: :cascade do |t|
    t.date "month"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "balance"
    t.integer "balance_last"
    t.index ["user_id"], name: "index_months_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "budgets", "months"
  add_foreign_key "budgets", "users"
  add_foreign_key "corrects", "deposits"
  add_foreign_key "corrects", "months"
  add_foreign_key "corrects", "users"
  add_foreign_key "deposits", "months"
  add_foreign_key "deposits", "users"
  add_foreign_key "details", "months"
  add_foreign_key "details", "users"
  add_foreign_key "months", "users"
end
