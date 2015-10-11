json.array!(@admin_daily_reports) do |admin_daily_report|
  json.extract! admin_daily_report, :id, :date, :grade, :subject, :homework, :tests, :note, :other
  json.url admin_daily_report_url(admin_daily_report, format: :json)
end
