# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "automation_run", id: :serial, force: :cascade do |t|
    t.string "timestamp", limit: 10, null: false
    t.string "os", limit: 30, null: false
    t.integer "build_number", null: false
  end

  create_table "test", primary_key: "name", id: :string, limit: 250, force: :cascade do |t|
    t.string "owner", limit: 355, null: false
  end

  create_table "test_run", id: :serial, force: :cascade do |t|
    t.string "timestamp", limit: 18, null: false
    t.string "status", limit: 4, null: false
    t.string "test_name"
    t.integer "automation_run", null: false
  end

  add_foreign_key "test_run", "automation_run", column: "automation_run", name: "test_run_automation_run_fkey"
  add_foreign_key "test_run", "test", column: "test_name", primary_key: "name", name: "test_run_test_name_fkey"
end
