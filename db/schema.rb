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

ActiveRecord::Schema.define(version: 2020_09_18_090252) do

  create_table "aide_candidates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "last_result_no"
    t.integer "last_generate_no"
    t.integer "enemy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enemy_id"], name: "index_aide_candidates_on_enemy_id"
    t.index ["last_result_no", "e_no", "last_generate_no"], name: "lastresultno_eno"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

  create_table "aides", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "aide_no"
    t.string "name"
    t.integer "enemy_id"
    t.integer "cost_sp"
    t.integer "bonds"
    t.integer "mhp"
    t.integer "msp"
    t.integer "mep"
    t.integer "range"
    t.string "fuka_texts"
    t.string "skill_texts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bonds"], name: "index_aides_on_bonds"
    t.index ["cost_sp"], name: "index_aides_on_cost_sp"
    t.index ["enemy_id"], name: "index_aides_on_enemy_id"
    t.index ["mep"], name: "index_aides_on_mep"
    t.index ["mhp"], name: "index_aides_on_mhp"
    t.index ["msp"], name: "index_aides_on_msp"
    t.index ["range"], name: "index_aides_on_range"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

  create_table "battle_acters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_id"
    t.integer "act_id"
    t.integer "acter_type"
    t.integer "e_no"
    t.integer "enemy_id"
    t.integer "suffix_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acter_type"], name: "index_battle_acters_on_acter_type"
    t.index ["e_no"], name: "index_battle_acters_on_e_no"
    t.index ["enemy_id"], name: "index_battle_acters_on_enemy_id"
    t.index ["result_no", "acter_type", "battle_id", "generate_no"], name: "resultno_acttype"
    t.index ["result_no", "battle_id", "act_id", "generate_no"], name: "resultno_battleid"
    t.index ["suffix_id"], name: "index_battle_acters_on_suffix_id"
  end

  create_table "battle_actions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_id"
    t.integer "turn"
    t.integer "act_id"
    t.integer "act_type"
    t.integer "skill_id"
    t.integer "fuka_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lv"
    t.index ["act_type"], name: "index_battle_actions_on_act_type"
    t.index ["fuka_id"], name: "index_battle_actions_on_fuka_id"
    t.index ["lv"], name: "index_battle_actions_on_lv"
    t.index ["result_no", "act_type", "battle_id", "generate_no"], name: "resultno_acttype_battleid"
    t.index ["result_no", "act_type", "turn", "generate_no"], name: "resultno_acttype_turn"
    t.index ["result_no", "battle_id", "act_id", "generate_no", "act_type", "skill_id", "fuka_id"], name: "resultno_battleid"
    t.index ["result_no", "battle_id", "turn", "act_id", "generate_no"], name: "resultno_turn"
    t.index ["skill_id"], name: "index_battle_actions_on_skill_id"
    t.index ["turn"], name: "index_battle_actions_on_turn"
  end

  create_table "battle_buffers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_id"
    t.integer "act_id"
    t.integer "act_sub_id"
    t.integer "buffer_type"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffer_type"], name: "index_battle_buffers_on_buffer_type"
    t.index ["result_no", "battle_id", "act_id", "act_sub_id", "generate_no"], name: "resultno_battleid"
    t.index ["result_no", "buffer_type", "battle_id", "act_id", "act_sub_id", "generate_no"], name: "resultno_buffertype"
    t.index ["value"], name: "index_battle_buffers_on_value"
  end

  create_table "battle_damages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_id"
    t.integer "act_id"
    t.integer "act_sub_id"
    t.integer "damage_type"
    t.integer "element_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "abnormal_id"
    t.index ["abnormal_id"], name: "index_battle_damages_on_abnormal_id"
    t.index ["element_id"], name: "index_battle_damages_on_element_id"
    t.index ["result_no", "battle_id", "act_id", "act_sub_id", "generate_no"], name: "resultno_battleid"
    t.index ["result_no", "damage_type", "abnormal_id", "value"], name: "sort_abnormalid_value"
    t.index ["result_no", "damage_type", "battle_id", "act_id", "act_sub_id", "generate_no"], name: "resultno_damagetype"
    t.index ["result_no", "damage_type", "value"], name: "sort_value"
    t.index ["value"], name: "index_battle_damages_on_value"
  end

  create_table "battle_enemies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "party_no"
    t.integer "battle_type"
    t.integer "enemy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_type"], name: "index_battle_enemies_on_battle_type"
    t.index ["enemy_id"], name: "index_battle_enemies_on_enemy_id"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_partyno"
  end

  create_table "battle_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_id"
    t.string "battle_page"
    t.integer "battle_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_type"], name: "index_battle_infos_on_battle_type"
    t.index ["result_no", "battle_id", "generate_no"], name: "resultno_battleid"
  end

  create_table "battle_results", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "party_no"
    t.integer "battle_type"
    t.integer "last_result_no"
    t.integer "last_generate_no"
    t.integer "battle_id"
    t.integer "battle_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "enemy_names"
    t.index ["battle_result"], name: "index_battle_results_on_battle_result"
    t.index ["enemy_names"], name: "index_battle_results_on_enemy_names"
    t.index ["last_generate_no"], name: "index_battle_results_on_last_generate_no"
    t.index ["last_result_no", "party_no", "last_generate_no"], name: "lastresultno_partyno"
    t.index ["last_result_no"], name: "index_battle_results_on_last_result_no"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_partyno"
  end

  create_table "battle_targets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_id"
    t.integer "act_id"
    t.integer "act_sub_id"
    t.integer "target_type"
    t.integer "e_no"
    t.integer "enemy_id"
    t.integer "suffix_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_no"], name: "index_battle_targets_on_e_no"
    t.index ["enemy_id"], name: "index_battle_targets_on_enemy_id"
    t.index ["result_no", "battle_id", "act_id", "act_sub_id", "generate_no"], name: "resultno_battleid"
    t.index ["result_no", "target_type", "battle_id", "generate_no"], name: "resultno_targettype"
    t.index ["suffix_id"], name: "index_battle_targets_on_suffix_id"
    t.index ["target_type"], name: "index_battle_targets_on_target_type"
  end

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.string "name"
    t.integer "skill_id"
    t.integer "made_e_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["made_e_no"], name: "index_cards_on_made_e_no"
    t.index ["name"], name: "index_cards_on_name"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["skill_id"], name: "index_cards_on_skill_id"
  end

  create_table "compounds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "last_result_no"
    t.integer "last_generate_no"
    t.integer "source_1_i_no"
    t.string "source_1_name"
    t.integer "source_2_i_no"
    t.string "source_2_name"
    t.string "sources_name"
    t.integer "is_success"
    t.integer "compound_result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compound_result_id"], name: "index_compounds_on_compound_result_id"
    t.index ["is_success"], name: "index_compounds_on_is_success"
    t.index ["result_no", "compound_result_id", "e_no", "generate_no"], name: "resultno_compoundid_eno"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["source_1_i_no"], name: "index_compounds_on_source_1_i_no"
    t.index ["source_1_name"], name: "index_compounds_on_source_1_name"
    t.index ["source_2_i_no"], name: "index_compounds_on_source_2_i_no"
    t.index ["source_2_name"], name: "index_compounds_on_source_2_name"
    t.index ["sources_name"], name: "index_compounds_on_sources_name"
  end

  create_table "drop_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.string "name"
    t.integer "plus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_drop_items_on_name"
    t.index ["plus"], name: "index_drop_items_on_plus"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

  create_table "duel_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "battle_id"
    t.integer "left_party_no"
    t.integer "right_party_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_id"], name: "index_duel_infos_on_battle_id"
    t.index ["left_party_no"], name: "index_duel_infos_on_left_party_no"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
    t.index ["right_party_no"], name: "index_duel_infos_on_right_party_no"
  end

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
    t.integer "plus"
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
    t.index ["plus"], name: "index_items_on_plus"
    t.index ["range"], name: "index_items_on_range"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["strength"], name: "index_items_on_strength"
  end

  create_table "makes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "last_result_no"
    t.integer "last_generate_no"
    t.integer "i_no"
    t.string "name"
    t.integer "kind_id"
    t.integer "strength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "requester_e_no"
    t.string "source_name"
    t.index ["i_no"], name: "index_makes_on_i_no"
    t.index ["kind_id"], name: "index_makes_on_kind_id"
    t.index ["last_result_no", "e_no", "i_no", "last_generate_no"], name: "last_item"
    t.index ["requester_e_no"], name: "index_makes_on_requester_e_no"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["source_name"], name: "index_makes_on_source_name"
    t.index ["strength"], name: "index_makes_on_strength"
  end

  create_table "meals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "last_result_no"
    t.integer "last_generate_no"
    t.integer "i_no"
    t.string "name"
    t.integer "recovery"
    t.integer "effect_1_id"
    t.integer "effect_1_value"
    t.integer "effect_2_id"
    t.integer "effect_2_value"
    t.integer "effect_3_id"
    t.integer "effect_3_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["effect_1_id"], name: "index_meals_on_effect_1_id"
    t.index ["effect_1_value"], name: "index_meals_on_effect_1_value"
    t.index ["effect_2_id"], name: "index_meals_on_effect_2_id"
    t.index ["effect_2_value"], name: "index_meals_on_effect_2_value"
    t.index ["effect_3_id"], name: "index_meals_on_effect_3_id"
    t.index ["effect_3_value"], name: "index_meals_on_effect_3_value"
    t.index ["last_result_no", "e_no", "i_no", "last_generate_no"], name: "last_item"
    t.index ["name"], name: "index_meals_on_name"
    t.index ["recovery"], name: "index_meals_on_recovery"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

  create_table "move_party_counts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "party_no"
    t.integer "landform_id"
    t.integer "move_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["landform_id"], name: "index_move_party_counts_on_landform_id"
    t.index ["move_count"], name: "index_move_party_counts_on_move_count"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_partyno"
  end

  create_table "moves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "move_no"
    t.integer "field_id"
    t.string "area"
    t.string "area_column"
    t.integer "area_row"
    t.integer "landform_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area"], name: "index_moves_on_area"
    t.index ["area_column"], name: "index_moves_on_area_column"
    t.index ["area_row"], name: "index_moves_on_area_row"
    t.index ["field_id"], name: "index_moves_on_field_id"
    t.index ["landform_id"], name: "index_moves_on_landform_id"
    t.index ["move_no"], name: "index_moves_on_move_no"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
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

  create_table "new_actions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "skill_id"
    t.integer "fuka_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fuka_id"], name: "index_new_actions_on_fuka_id"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
    t.index ["skill_id"], name: "index_new_actions_on_skill_id"
  end

  create_table "new_battle_enemies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "enemy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "battle_type"
    t.index ["battle_type"], name: "index_new_battle_enemies_on_battle_type"
    t.index ["enemy_id"], name: "index_new_battle_enemies_on_enemy_id"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
  end

  create_table "new_defeat_enemies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "before_result_no"
    t.integer "before_generate_no"
    t.integer "party_no"
    t.integer "enemy_id"
    t.integer "member_num"
    t.integer "battle_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_type"], name: "index_new_defeat_enemies_on_battle_type"
    t.index ["before_result_no", "party_no", "before_generate_no"], name: "beforeresultno_partyno"
    t.index ["enemy_id"], name: "index_new_defeat_enemies_on_enemy_id"
    t.index ["member_num"], name: "index_new_defeat_enemies_on_member_num"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_partyno"
  end

  create_table "new_item_fukas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "fuka_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fuka_id"], name: "index_new_item_fukas_on_fuka_id"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
  end

  create_table "new_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "association_name"
    t.index ["association_name"], name: "index_new_items_on_association_name"
    t.index ["name"], name: "index_new_items_on_name"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
  end

  create_table "new_next_enemies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "enemy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "battle_type"
    t.index ["battle_type"], name: "index_new_next_enemies_on_battle_type"
    t.index ["enemy_id"], name: "index_new_next_enemies_on_enemy_id"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
  end

  create_table "next_battle_enemies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "party_no"
    t.integer "battle_type"
    t.integer "enemy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_type"], name: "index_next_battle_enemies_on_battle_type"
    t.index ["enemy_id"], name: "index_next_battle_enemies_on_enemy_id"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_partyno"
  end

  create_table "next_battle_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "party_no"
    t.integer "battle_type"
    t.integer "enemy_party_name_id"
    t.integer "member_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "enemy_names"
    t.index ["battle_type"], name: "index_next_battle_infos_on_battle_type"
    t.index ["enemy_names"], name: "index_next_battle_infos_on_enemy_names"
    t.index ["enemy_party_name_id"], name: "index_next_battle_infos_on_enemy_party_name_id"
    t.index ["member_num"], name: "index_next_battle_infos_on_member_num"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_partyno"
  end

  create_table "next_duel_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "left_party_no"
    t.integer "right_party_no"
    t.integer "battle_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_type"], name: "index_next_duel_infos_on_battle_type"
    t.index ["left_party_no"], name: "index_next_duel_infos_on_left_party_no"
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
    t.index ["right_party_no"], name: "index_next_duel_infos_on_right_party_no"
  end

  create_table "onetime_studies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "skill_id"
    t.integer "depth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["depth"], name: "index_onetime_studies_on_depth"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["skill_id"], name: "index_onetime_studies_on_skill_id"
  end

  create_table "parties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "party_type"
    t.integer "party_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_no"], name: "index_parties_on_party_no"
    t.index ["party_type"], name: "index_parties_on_party_type"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

  create_table "party_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "party_no"
    t.integer "party_type"
    t.string "name"
    t.integer "member_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_num"], name: "index_party_infos_on_member_num"
    t.index ["name"], name: "index_party_infos_on_name"
    t.index ["party_type"], name: "index_party_infos_on_party_type"
    t.index ["result_no", "party_no", "generate_no"], name: "resultno_eno"
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

  create_table "skill_concatenates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.text "skill_concatenate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
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

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "style_id"
    t.integer "effect"
    t.integer "mhp"
    t.integer "msp"
    t.integer "landform_id"
    t.integer "condition"
    t.integer "max_condition"
    t.integer "ps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["condition"], name: "index_statuses_on_condition"
    t.index ["effect"], name: "index_statuses_on_effect"
    t.index ["landform_id"], name: "index_statuses_on_landform_id"
    t.index ["max_condition"], name: "index_statuses_on_max_condition"
    t.index ["mhp"], name: "index_statuses_on_mhp"
    t.index ["msp"], name: "index_statuses_on_msp"
    t.index ["ps"], name: "index_statuses_on_ps"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["style_id"], name: "index_statuses_on_style_id"
  end

  create_table "studies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "skill_id"
    t.integer "depth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["depth"], name: "index_studies_on_depth"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["skill_id"], name: "index_studies_on_skill_id"
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

  create_table "uploaded_checks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
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
