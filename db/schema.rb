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

ActiveRecord::Schema.define(version: 2018_06_23_095116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "blocks_sessions", id: false, force: :cascade do |t|
    t.bigint "session_id"
    t.bigint "block_id"
    t.index ["block_id"], name: "index_blocks_sessions_on_block_id"
    t.index ["session_id"], name: "index_blocks_sessions_on_session_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sentences", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
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

  add_foreign_key "blocks", "sentences"
  add_foreign_key "blocks", "translations"
  add_foreign_key "translations", "languages"
  add_foreign_key "translations", "sentences", column: "original_id"
end
