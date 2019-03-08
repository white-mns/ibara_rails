json.extract! uploaded_check, :id, :result_no, :generate_no, :created_at, :updated_at
json.url uploaded_check_url(uploaded_check, format: :json)
