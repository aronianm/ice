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

ActiveRecord::Schema[7.0].define(version: 2023_03_08_023609) do
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

  create_table "exercise_users", force: :cascade do |t|
    t.integer "program_id"
    t.integer "user_id"
    t.integer "exercise_id"
    t.integer "sets"
    t.integer "reps"
    t.integer "duration"
    t.text "notes"
  end

  create_table "exercise_workouts", force: :cascade do |t|
    t.integer "workout_id"
    t.integer "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name", null: false
    t.integer "target_muscle_id", null: false
    t.integer "target_sub_muscle_id"
    t.text "definition"
    t.integer "created_by", null: false
    t.integer "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "typ"
    t.index ["name", "target_muscle_id", "created_by"], name: "index_exercises_on_name_and_target_muscle_id_and_created_by", unique: true
  end

  create_table "muscles", force: :cascade do |t|
    t.string "name"
    t.integer "created_by", null: false
    t.integer "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
  end

  create_table "program_exercises", force: :cascade do |t|
    t.integer "program_id"
    t.integer "exercise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string "name"
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "user_programs", force: :cascade do |t|
    t.integer "program_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "fname"
    t.string "lname"
    t.integer "height"
    t.integer "weight"
    t.string "level"
    t.string "goal"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
    t.date "day"
    t.text "notes"
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "exercise_users", "exercises"
  add_foreign_key "exercise_users", "programs"
  add_foreign_key "exercise_users", "users"
  add_foreign_key "exercise_workouts", "exercises"
  add_foreign_key "exercise_workouts", "workouts"
  add_foreign_key "exercises", "muscles", column: "target_muscle_id"
  add_foreign_key "exercises", "muscles", column: "target_sub_muscle_id"
  add_foreign_key "exercises", "users", column: "created_by"
  add_foreign_key "exercises", "users", column: "updated_by"
  add_foreign_key "muscles", "users", column: "created_by"
  add_foreign_key "muscles", "users", column: "updated_by"
  add_foreign_key "program_exercises", "exercises"
  add_foreign_key "program_exercises", "programs"
  add_foreign_key "user_programs", "programs"
  add_foreign_key "user_programs", "users"
  add_foreign_key "users_roles", "roles"
  add_foreign_key "users_roles", "users"
end
