class SchoolTest
  include Mongoid::Document

  field :name
  field :test_date, type: Date
  field :subjects, type: Array #[{ name:,average:, test_range: },]

  def display_date
    test_date
  end
end
