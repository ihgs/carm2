class SchoolTest
  include Mongoid::Document

  field :name
  field :test_date, type: Date
  field :subjects, type: Array #[{ name:,average:, test_range: },]

end
