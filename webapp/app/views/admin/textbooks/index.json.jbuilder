json.array!(@textbooks) do |textbook|
  json.extract! textbook, :id, :name, :subject, :grade, :units
  json.url admin_textbook_url(textbook, format: :json)
end
