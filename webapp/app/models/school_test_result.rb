class SchoolTestResult
  include Mongoid::Document
  field :student_id, type: String
  field :school_test_id, type: String
  field :results, type: Array  #{:subject, :score}
end
