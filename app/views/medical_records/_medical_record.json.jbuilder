json.extract! medical_record, :id, :user_id, :level, :created_at, :updated_at
json.url medical_record_url(medical_record, format: :json)
