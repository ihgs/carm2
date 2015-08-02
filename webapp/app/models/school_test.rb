class SchoolTest
  include Mongoid::Document

  field :name
  field :test_date, type: Date
  field :subjects, type: Array #[{ subject:,average:, test_range: },]

end
