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

ActiveRecord::Schema.define(version: 2019_02_22_190622) do

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "i_no"
    t.string "name"
    t.integer "kind_id"
    t.integer "strength"
    t.integer "range"
    t.integer "effect_1_id"
    t.integer "effect_1_value"
    t.integer "effect_1_need_lv"
    t.integer "effect_2_id"
    t.integer "effect_2_value"
    t.integer "effect_2_need_lv"
    t.integer "effect_3_id"
    t.integer "effect_3_value"
    t.integer "effect_3_need_lv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["effect_1_id"], name: "index_items_on_effect_1_id"
    t.index ["effect_1_need_lv"], name: "index_items_on_effect_1_need_lv"
    t.index ["effect_1_value"], name: "index_items_on_effect_1_value"
    t.index ["effect_2_id"], name: "index_items_on_effect_2_id"
    t.index ["effect_2_need_lv"], name: "index_items_on_effect_2_need_lv"
    t.index ["effect_2_value"], name: "index_items_on_effect_2_value"
    t.index ["effect_3_id"], name: "index_items_on_effect_3_id"
    t.index ["effect_3_need_lv"], name: "index_items_on_effect_3_need_lv"
    t.index ["effect_3_value"], name: "index_items_on_effect_3_value"
    t.index ["kind_id"], name: "index_items_on_kind_id"
    t.index ["name"], name: "index_items_on_name"
    t.index ["range"], name: "index_items_on_range"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["strength"], name: "index_items_on_strength"
  end

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

  create_table "parties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "party_type"
    t.integer "party"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party"], name: "index_parties_on_party"
    t.index ["party_type"], name: "index_parties_on_party_type"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

  create_table "places", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "field_id"
    t.string "area"
    t.string "area_column"
    t.integer "area_row"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area"], name: "index_places_on_area"
    t.index ["area_column"], name: "index_places_on_area_column"
    t.index ["area_row"], name: "index_places_on_area_row"
    t.index ["field_id"], name: "index_places_on_field_id"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["result_no", "field_id", "area", "generate_no"], name: "resultno_place_area"
    t.index ["result_no", "field_id", "area_column", "area_row", "generate_no"], name: "resultno_place_col_row"
  end

  create_table "proper_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "proper_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_proper_names_on_name"
    t.index ["proper_id"], name: "index_proper_names_on_proper_id"
  end

  create_table "skill_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "skill_id"
    t.string "name"
    t.integer "type_id"
    t.integer "element_id"
    t.integer "ep"
    t.integer "sp"
    t.integer "timing_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["element_id"], name: "index_skill_data_on_element_id"
    t.index ["ep"], name: "index_skill_data_on_ep"
    t.index ["name"], name: "index_skill_data_on_name"
    t.index ["skill_id"], name: "index_skill_data_on_skill_id"
    t.index ["sp"], name: "index_skill_data_on_sp"
    t.index ["text"], name: "index_skill_data_on_text"
    t.index ["timing_id"], name: "index_skill_data_on_timing_id"
    t.index ["type_id"], name: "index_skill_data_on_type_id"
  end

  create_table "skill_masteries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "skill_id"
    t.integer "requirement_1_id"
    t.integer "requirement_1_lv"
    t.integer "requirement_2_id"
    t.integer "requirement_2_lv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requirement_1_id"], name: "index_skill_masteries_on_requirement_1_id"
    t.index ["requirement_1_lv"], name: "index_skill_masteries_on_requirement_1_lv"
    t.index ["requirement_2_id"], name: "index_skill_masteries_on_requirement_2_id"
    t.index ["requirement_2_lv"], name: "index_skill_masteries_on_requirement_2_lv"
    t.index ["skill_id"], name: "index_skill_masteries_on_skill_id"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.string "name"
    t.integer "skill_id"
    t.integer "lv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lv"], name: "index_skills_on_lv"
    t.index ["name"], name: "index_skills_on_name"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["skill_id"], name: "index_skills_on_skill_id"
  end

  create_table "superpower_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "superpower_id"
    t.string "name"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_superpower_data_on_name"
    t.index ["superpower_id"], name: "index_superpower_data_on_superpower_id"
  end

  create_table "superpowers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "superpower_id"
    t.integer "lv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lv"], name: "index_superpowers_on_lv"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["superpower_id"], name: "index_superpowers_on_superpower_id"
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
