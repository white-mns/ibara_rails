json.extract! duel_info, :id, :result_no, :generate_no, :battle_id, :left_party_no, :right_party_no, :created_at, :updated_at
json.url duel_info_url(duel_info, format: :json)
