json.array!(@questions) do |question|
  json.extract! question, :id, :poll, :event
  json.url question_url(question, format: :json)
end
