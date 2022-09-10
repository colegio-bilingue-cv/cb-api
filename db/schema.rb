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

ActiveRecord::Schema[7.0].define(version: 2022_09_06_001245) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "students", force: :cascade do |t|
    t.string "ci"
    t.string "surname"
    t.string "second_surname"
    t.string "first_name"
    t.string "middle_name"
    t.string "group"
    t.string "sub_group"
    t.string "scheduler_start"
    t.string "scheduler_end"
    t.string "tuition"
    t.integer "reference_number"
    t.string "birthplace"
    t.datetime "birthdate"
    t.string "nacionality"
    t.string "first_language"
    t.string "office"
    t.string "state"
    t.string "address"
    t.string "neighborhood"
    t.string "medical_assurance"
    t.string "emergency"
    t.string "vaccine_name"
    t.datetime "vaccine_expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
