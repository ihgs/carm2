json.array!(@admin_students) do |admin_student|
  json.extract! admin_student, :id
  json.url admin_student_url(admin_student, format: :json)
end
