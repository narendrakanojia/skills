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

ActiveRecord::Schema.define(version: 20161031092413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.text     "description"
    t.datetime "updated_at"
    t.string   "updated_by"
    t.datetime "created_at"
    t.text     "role"
    t.integer  "year_from"
    t.integer  "year_to"
    t.integer  "person_id"
  end

  create_table "advanced_trainings", force: :cascade do |t|
    t.text     "description"
    t.datetime "updated_at"
    t.string   "updated_by"
    t.datetime "created_at"
    t.integer  "year_from"
    t.integer  "year_to"
    t.integer  "person_id"
  end

  create_table "competences", force: :cascade do |t|
    t.text     "description"
    t.datetime "updated_at"
    t.string   "updated_by"
    t.integer  "person_id"
  end

  create_table "educations", force: :cascade do |t|
    t.text     "location"
    t.text     "type"
    t.datetime "updated_at"
    t.string   "updated_by"
    t.integer  "year_from"
    t.integer  "year_to"
    t.integer  "person_id"
  end

  create_table "people", force: :cascade do |t|
    t.datetime "birthdate"
    t.binary   "profile_picture",  null: false
    t.string   "language"
    t.string   "location"
    t.string   "martial_status"
    t.datetime "updated_at"
    t.string   "updated_by"
    t.datetime "created_at"
    t.string   "name"
    t.string   "origin"
    t.string   "role"
    t.string   "title"
    t.integer  "status_id"
    t.integer  "origin_person_id"
    t.string   "variation_name"
    t.datetime "variation_date"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "updated_at"
    t.string   "updated_by"
    t.datetime "created_at"
    t.text     "description"
    t.text     "title"
    t.text     "role"
    t.text     "technology"
    t.integer  "year_to"
    t.integer  "person_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "status"
  end

end
