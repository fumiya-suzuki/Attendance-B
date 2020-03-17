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

ActiveRecord::Schema.define(version: 20200316132039) do

  create_table "approvals", force: :cascade do |t|
    t.integer "superior_id"
    t.integer "superior_comfirm", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approval_change"
    t.date "month"
    t.index ["user_id"], name: "index_approvals_on_user_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "scheduled_end_time"
    t.string "occupation"
    t.boolean "superior_confirmation"
    t.integer "over_id"
    t.integer "over_confirm", default: 0
    t.boolean "over_change", default: false
    t.integer "onemonth_confirm"
    t.integer "onemonth_id"
    t.datetime "beta_started_at"
    t.datetime "beta_finished_at"
    t.string "beta_note"
    t.boolean "one_month_change", default: false
    t.boolean "over_next_day", default: false
    t.boolean "one_next_day", default: false
    t.date "one_month"
    t.date "over_month"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "base_name"
    t.integer "base_number"
    t.string "base_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "department"
    t.datetime "basic_time", default: "2020-03-16 23:00:00"
    t.datetime "work_time", default: "2020-03-16 22:30:00"
    t.datetime "basic_start_time", default: "2020-03-16 23:00:00"
    t.datetime "basic_leave_time", default: "2020-03-17 08:00:00"
    t.boolean "superior", default: false
    t.integer "employee_number"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
