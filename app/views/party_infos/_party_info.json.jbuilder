json.extract! party_info, :id, :result_no, :generate_no, :party_no, :party_type, :name, :member_num, :created_at, :updated_at
json.url party_info_url(party_info, format: :json)
