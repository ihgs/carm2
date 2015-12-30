json.array!(@admin_textbooks) do |admin_textbook|
  json.extract! admin_textbook, :id, :name, :subject, :grade, :category
  json.url admin_textbook_url(admin_textbook, format: :json)
end
