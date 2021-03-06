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

ActiveRecord::Schema.define(version: 2020_02_21_035914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "automation_runs", force: :cascade do |t|
    t.string "timestamp", null: false
    t.string "os", null: false
    t.integer "build_number", null: false
  end

  create_table "test_runs", force: :cascade do |t|
    t.string "timestamp", null: false
    t.string "status", null: false
    t.bigint "test_id"
    t.bigint "automation_runs_id"
    t.index ["automation_runs_id"], name: "index_test_runs_on_automation_runs_id"
    t.index ["test_id"], name: "index_test_runs_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "owner", null: false
    t.string "name", null: false
    t.index ["name"], name: "index_tests_on_name", unique: true
  end

  add_foreign_key "test_runs", "automation_runs", column: "automation_runs_id"
  add_foreign_key "test_runs", "tests"
end
