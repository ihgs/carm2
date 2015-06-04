json.array!(@schools) do |school|
  json.extract! school, :id, :name, :kind, :note, :address
  json.url school_url(school, format: :json)
end
