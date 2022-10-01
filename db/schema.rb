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

ActiveRecord::Schema[7.0].define(version: 2022_09_26_203722) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "text"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_comments_on_student_id"
  end

  create_table "family_members", force: :cascade do |t|
    t.string "ci"
    t.string "role"
    t.string "full_name"
    t.date "birthdate"
    t.string "birthplace"
    t.string "nationality"
    t.string "first_language"
    t.string "marital_status"
    t.string "cellphone"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "education_level"
    t.string "occupation"
    t.string "workplace"
    t.string "workplace_neighbourhood"
    t.string "workplace_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "family_members_students", id: false, force: :cascade do |t|
    t.bigint "family_member_id", null: false
    t.bigint "student_id", null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_payment_methods", id: false, force: :cascade do |t|
    t.bigint "payment_method_id", null: false
    t.bigint "student_id", null: false
    t.date "year"
  end

  create_table "student_type_scholarships", id: false, force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "type_scholarship_id", null: false
    t.date "date"
  end

  create_table "students", force: :cascade do |t|
    t.string "ci"
    t.string "surname"
    t.string "name"
    t.string "schedule_start"
    t.string "schedule_end"
    t.string "tuition"
    t.integer "reference_number"
    t.string "birthplace"
    t.date "birthdate"
    t.string "nationality"
    t.string "first_language"
    t.string "office"
    t.integer "status", default: 0
    t.string "address"
    t.string "neighborhood"
    t.string "medical_assurance"
    t.string "emergency"
    t.string "phone_number"
    t.string "vaccine_name"
    t.date "vaccine_expiration"
    t.date "inscription_date"
    t.date "starting_date"
    t.string "contact"
    t.string "contact_phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "type_scholarships", force: :cascade do |t|
    t.string "description"
    t.integer "scholarship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
