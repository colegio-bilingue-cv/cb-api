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

ActiveRecord::Schema[7.0].define(version: 2022_10_23_225624) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "allowlisted_jwts", force: :cascade do |t|
    t.string "jti", null: false
    t.string "aud"
    t.datetime "exp", null: false
    t.bigint "user_id", null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "answers", id: false, force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "student_id", null: false
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "student_id"], name: "index_answers_on_question_id_and_student_id"
    t.index ["student_id", "question_id"], name: "index_answers_on_student_id_and_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cicles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cicles_questions", id: false, force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "cicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cicle_id", "question_id"], name: "index_cicles_questions_on_cicle_id_and_question_id"
    t.index ["question_id", "cicle_id"], name: "index_cicles_questions_on_question_id_and_cicle_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "text"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_comments_on_student_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.integer "percentage"
    t.integer "explanation"
    t.date "start_date"
    t.date "end_date"
    t.text "resolution_description"
    t.integer "administrative_type"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_discounts_on_student_id"
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
    t.string "workplace_address"
  end

  create_table "family_members_students", id: false, force: :cascade do |t|
    t.bigint "family_member_id", null: false
    t.bigint "student_id", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.bigint "cicle_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cicle_id"], name: "index_grades_on_cicle_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "grade_id", null: false
    t.string "name"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_id"], name: "index_groups_on_grade_id"
  end

  create_table "intermediate_evaluations", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "group_id"
    t.date "starting_month"
    t.date "ending_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_intermediate_evaluations_on_group_id"
    t.index ["student_id"], name: "index_intermediate_evaluations_on_student_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_questions_on_category_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "student_payment_methods", force: :cascade do |t|
    t.bigint "payment_method_id", null: false
    t.bigint "student_id", null: false
    t.date "year"
    t.index ["student_id", "payment_method_id", "year"], name: "index_student_payment_method_year", unique: true
  end

  create_table "student_type_scholarships", force: :cascade do |t|
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
    t.bigint "group_id"
    t.bigint "cicle_id"
    t.index ["cicle_id"], name: "index_students_on_cicle_id"
    t.index ["group_id"], name: "index_students_on_group_id"
  end

  create_table "type_scholarships", force: :cascade do |t|
    t.string "description"
    t.integer "scholarship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.date "birthdate"
    t.string "address"
    t.string "phone_number"
    t.string "ci"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ci"], name: "index_users_on_ci", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
  add_foreign_key "grades", "cicles"
  add_foreign_key "groups", "grades"
  add_foreign_key "questions", "categories"
  add_foreign_key "students", "cicles"
  add_foreign_key "students", "groups"
end
