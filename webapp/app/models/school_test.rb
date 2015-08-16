class SchoolTest
  include Mongoid::Document

  field :name
  field :start_date, type: Date
  field :end_date, type: Date
  field :school_id, type: String
  field :grade, type: Integer
  field :subjects, type: Array #[{ name:,average:, test_range: },]

  def display_date
    if end_date.nil?
      start_date
    else
      "#{start_date}〜#{end_date}"
    end
  end

  def display_school
    school_data = school
    if school_data
      "#{school_data.name}#{school_data.kind} #{self.grade}年"
    else
      ""
    end
  end
  def school
    begin
      School.find(self.school_id) if self.school_id
    rescue
    end
  end
end
