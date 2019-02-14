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

ActiveRecord::Schema.define(version: 2019_02_14_104241) do

  create_table "names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.string "name"
    t.string "player"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

  create_table "worlds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "world"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["world"], name: "index_worlds_on_world"
  end

end
