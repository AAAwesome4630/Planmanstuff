# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20171007215139) do

  create_table "admin_announcements", force: :cascade do |t|
    t.integer  "admin_id"
    t.string   "header"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "administrators", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "school_id",              default: 0,     null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.boolean  "admin",                  default: false
    t.string   "avatar"
  end

  add_index "administrators", ["email"], name: "index_administrators_on_email", unique: true
  add_index "administrators", ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true

  create_table "announcements", force: :cascade do |t|
    t.string   "header"
    t.string   "content"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.date     "due_date"
    t.string   "name"
    t.integer  "classroom_id"
    t.integer  "rec_days"
    t.integer  "eta"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "classrooms", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.string   "subject"
    t.integer  "numberOfStudents", default: 0,          null: false
    t.integer  "teacher_id"
    t.string   "description"
    t.string   "password_digest"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "students",         default: "--- []\n"
  end

  add_index "classrooms", ["name", "teacher_id"], name: "index_classrooms_on_name_and_teacher_id"

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "individual_assignments", force: :cascade do |t|
    t.integer  "assignment_id"
    t.integer  "time_remaining"
    t.boolean  "finished",       default: false
    t.integer  "student_id"
    t.integer  "rec_days"
    t.integer  "classroom_id"
    t.date     "due_date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "individual_assignments", ["assignment_id", "student_id"], name: "index_individual_assignments_on_assignment_id_and_student_id", unique: true

  create_table "individual_quizzes", force: :cascade do |t|
    t.integer  "quiz_id"
    t.integer  "time_remaining"
    t.integer  "rec_days"
    t.boolean  "finished",       default: false
    t.integer  "student_id"
    t.integer  "classroom_id"
    t.date     "date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "individual_quizzes", ["quiz_id", "student_id"], name: "index_individual_quizzes_on_quiz_id_and_student_id", unique: true

  create_table "individual_tests", force: :cascade do |t|
    t.integer  "test_id"
    t.integer  "time_remaining"
    t.integer  "rec_days"
    t.boolean  "finished",       default: false
    t.integer  "student_id"
    t.integer  "classroom_id"
    t.date     "date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "individual_tests", ["test_id", "student_id"], name: "index_individual_tests_on_test_id_and_student_id", unique: true

  create_table "quizzes", force: :cascade do |t|
    t.date     "date"
    t.string   "topic"
    t.integer  "classroom_id"
    t.integer  "rec_days"
    t.integer  "eta"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sc_relationships", force: :cascade do |t|
    t.integer  "classroom_id"
    t.integer  "student_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "sc_relationships", ["classroom_id", "student_id"], name: "index_sc_relationships_on_classroom_id_and_student_id", unique: true

  create_table "school_sign_up_tokens", force: :cascade do |t|
    t.string   "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "type"
    t.string   "city"
    t.string   "zipcode"
    t.string   "state"
    t.string   "country"
    t.string   "mascot"
    t.string   "website"
    t.integer  "numberOfTeachers", default: 0
    t.integer  "NCES_id"
    t.string   "password_digest"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "administrators",   default: "--- []\n"
    t.text     "teachers",         default: "--- []\n"
    t.text     "students",         default: "--- []\n"
  end

  add_index "schools", ["name", "address"], name: "index_schools_on_name_and_address", unique: true

  create_table "students", force: :cascade do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "school_id",              default: 0,          null: false
    t.text     "classrooms",             default: "--- []\n"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true

  create_table "t_files", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "school_id",              default: 0,          null: false
    t.text     "classrooms",             default: "--- []\n"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "avatar"
  end

  add_index "teachers", ["email"], name: "index_teachers_on_email", unique: true
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true

  create_table "tests", force: :cascade do |t|
    t.date     "date"
    t.string   "topic"
    t.integer  "classroom_id"
    t.integer  "rec_days"
    t.integer  "eta"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
