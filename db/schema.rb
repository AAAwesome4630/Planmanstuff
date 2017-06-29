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

ActiveRecord::Schema.define(version: 20170628212527) do

  create_table "admin_announcements", force: :cascade do |t|
    t.integer  "admin_id"
    t.string   "header"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "administrators", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "school_id",              default: 0,  null: false
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
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "eta"
    t.integer  "rec_days"
    t.string   "description"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.string   "subject"
    t.integer  "numberOfStudents", default: 0,          null: false
    t.integer  "teacher_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "students",         default: "--- []\n"
    t.string   "password"
    t.string   "password_digest"
  end

  add_index "classrooms", ["name", "teacher_id"], name: "index_classrooms_on_name_and_teacher_id"
  add_index "classrooms", ["numberOfStudents", "teacher_id"], name: "index_classrooms_on_numberOfStudents_and_teacher_id"
  add_index "classrooms", ["subject", "teacher_id"], name: "index_classrooms_on_subject_and_teacher_id"

  create_table "individual_assignments", force: :cascade do |t|
    t.integer  "assignment_id"
    t.integer  "time_remaining"
    t.boolean  "finished",       default: false
    t.integer  "student_id"
    t.integer  "rec_days"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "individual_quizzes", force: :cascade do |t|
    t.integer  "quiz_id"
    t.integer  "student_id"
    t.integer  "time_remaining"
    t.integer  "rec_days"
    t.boolean  "finshed",        default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "individual_tests", force: :cascade do |t|
    t.integer  "test_id"
    t.integer  "time_remaining"
    t.integer  "rec_days"
    t.boolean  "finished",       default: false
    t.integer  "student_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer  "classroom_id"
    t.date     "date"
    t.string   "topic"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "s_srelationships", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "s_srelationships", ["school_id", "student_id"], name: "index_s_srelationships_on_school_id_and_student_id", unique: true

  create_table "sc_relationships", force: :cascade do |t|
    t.integer  "classroom_id"
    t.integer  "student_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "sc_relationships", ["classroom_id", "student_id"], name: "index_sc_relationships_on_classroom_id_and_student_id", unique: true
  add_index "sc_relationships", ["classroom_id"], name: "index_sc_relationships_on_classroom_id"
  add_index "sc_relationships", ["student_id"], name: "index_sc_relationships_on_student_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "type"
    t.string   "state"
    t.string   "country"
    t.string   "mascot"
    t.string   "website"
    t.integer  "numberOfTeachers"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "administrators",   default: "--- []\n"
    t.text     "teachers",         default: "--- []\n"
    t.text     "students",         default: "--- []\n"
  end

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
    t.text     "classrooms",             default: "--- []\n"
    t.integer  "school_id",              default: 0
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

  create_table "t_srelationships", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "t_srelationships", ["school_id", "teacher_id"], name: "index_t_srelationships_on_school_id_and_teacher_id", unique: true

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
    t.integer  "school_id",              default: 0
    t.text     "classrooms",             default: "--- []\n"
  end

  add_index "teachers", ["email"], name: "index_teachers_on_email", unique: true
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true

  create_table "tests", force: :cascade do |t|
    t.date     "date"
    t.string   "topic"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "eta"
    t.string   "description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
