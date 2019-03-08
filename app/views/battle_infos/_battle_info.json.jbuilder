json.extract! battle_info, :id, :result_no, :generate_no, :battle_id, :battle_page, :battle_type, :created_at, :updated_at
json.url battle_info_url(battle_info, format: :json)
