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

ActiveRecord::Schema.define(version: 2019_03_21_220022) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "blocks", force: :cascade do |t|
    t.string "transcript"
    t.bigint "translation_id"
    t.integer "target_language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sentence_id"
    t.index ["sentence_id"], name: "index_blocks_on_sentence_id"
    t.index ["target_language_id"], name: "index_blocks_on_target_language_id"
    t.index ["translation_id"], name: "index_blocks_on_translation_id"
  end

  create_table "blocks_lessons", id: false, force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "block_id"
    t.index ["block_id"], name: "index_blocks_lessons_on_block_id"
    t.index ["lesson_id"], name: "index_blocks_lessons_on_lesson_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "target_language_id"
    t.index ["target_language_id"], name: "index_lessons_on_target_language_id"
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "sentences", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", force: :cascade do |t|
    t.bigint "original_id"
    t.bigint "language_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_translations_on_language_id"
    t.index ["original_id"], name: "index_translations_on_original_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "blocks", "sentences"
  add_foreign_key "blocks", "translations"
  add_foreign_key "lessons", "languages", column: "target_language_id"
  add_foreign_key "lessons", "users"
  add_foreign_key "translations", "languages"
  add_foreign_key "translations", "sentences", column: "original_id"
end
