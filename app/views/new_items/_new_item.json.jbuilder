json.extract! new_item, :id, :result_no, :generate_no, :name, :created_at, :updated_at
json.url new_item_url(new_item, format: :json)
