json.array!(@students) do |admin_student|
  json.extract! admin_student, :id, :name, :card_id, :schools
  json.url admin_student_url(admin_student, format: :json)
end
