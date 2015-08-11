class SchoolTest
  include Mongoid::Document

  field :name
  field :start_date, type: Date
  field :end_date, type: Date
  field :subjects, type: Array #[{ name:,average:, test_range: },]

  def display_date
    if end_date.nil? 
      start_date
    else
      "#{start_date}〜#{end_date}"
    end
  end
end
