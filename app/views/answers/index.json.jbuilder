json.array!(@answers) do |answer|
  json.extract! answer, :id, :response, :question, :event, :user
  json.url answer_url(answer, format: :json)
end
