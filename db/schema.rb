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

ActiveRecord::Schema.define(version: 2019_07_29_183457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
  end

  create_table "branches", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.decimal "lat", precision: 9, scale: 7
    t.decimal "lng", precision: 9, scale: 7
    t.bigint "institution_id"
    t.string "cep", null: false
    t.string "neighborhood", null: false
    t.string "federation_id", null: false
    t.string "complement"
    t.string "city", null: false
    t.string "street", null: false
    t.string "address_number", null: false
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_branches_on_institution_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "branch_id"
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_courses_on_branch_id"
  end

  create_table "courses_units", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "unit_id", null: false
    t.index ["course_id", "unit_id"], name: "index_courses_units_on_course_id_and_unit_id"
    t.index ["unit_id", "course_id"], name: "index_courses_units_on_unit_id_and_course_id"
  end

  create_table "grade_unit_students", force: :cascade do |t|
    t.bigint "grade_unit_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_unit_id"], name: "index_grade_unit_students_on_grade_unit_id"
    t.index ["student_id"], name: "index_grade_unit_students_on_student_id"
  end

  create_table "grade_unit_teachers", force: :cascade do |t|
    t.bigint "grade_unit_id"
    t.bigint "teacher_id"
    t.datetime "teacher_clock_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_unit_id"], name: "index_grade_unit_teachers_on_grade_unit_id"
    t.index ["teacher_id"], name: "index_grade_unit_teachers_on_teacher_id"
  end

  create_table "grade_units", force: :cascade do |t|
    t.bigint "grade_id", null: false
    t.bigint "unit_id", null: false
    t.bigint "group_id", null: false
    t.datetime "starts_on", null: false
    t.datetime "ends_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_lectures"
    t.index ["grade_id"], name: "index_grade_units_on_grade_id"
    t.index ["group_id"], name: "index_grade_units_on_group_id"
    t.index ["unit_id"], name: "index_grade_units_on_unit_id"
  end

  create_table "grades", force: :cascade do |t|
    t.bigint "branch_id"
    t.string "title", null: false
    t.date "begin_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_grades_on_branch_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_groups_on_unit_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_institutions_on_admin_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "grade_unit_id"
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_unit_id"], name: "index_messages_on_grade_unit_id"
  end

  create_table "students", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "branch_id"
    t.string "name", null: false
    t.string "cellphone"
    t.date "birthdate"
    t.string "enrollment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_students_on_branch_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "institution_id"
    t.string "name", null: false
    t.string "cellphone"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_teachers_on_institution_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "timesheets", force: :cascade do |t|
    t.bigint "grade_unit_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_unit_id"], name: "index_timesheets_on_grade_unit_id"
    t.index ["student_id"], name: "index_timesheets_on_student_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "branch_id"
    t.string "name", null: false
    t.string "code", null: false
    t.integer "kind", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_units_on_branch_id"
    t.index ["course_id"], name: "index_units_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.json "tokens"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tax_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "branches", "institutions"
  add_foreign_key "courses", "branches"
  add_foreign_key "grade_unit_students", "grade_units"
  add_foreign_key "grade_unit_students", "students"
  add_foreign_key "grade_unit_teachers", "grade_units"
  add_foreign_key "grade_unit_teachers", "teachers"
  add_foreign_key "grade_units", "grades"
  add_foreign_key "grade_units", "groups"
  add_foreign_key "grade_units", "units"
  add_foreign_key "grades", "branches"
  add_foreign_key "groups", "units"
  add_foreign_key "institutions", "admins"
  add_foreign_key "messages", "grade_units"
  add_foreign_key "students", "branches"
  add_foreign_key "students", "users"
  add_foreign_key "teachers", "institutions"
  add_foreign_key "teachers", "users"
  add_foreign_key "timesheets", "grade_units"
  add_foreign_key "timesheets", "students"
  add_foreign_key "units", "branches"
  add_foreign_key "units", "courses"
end
