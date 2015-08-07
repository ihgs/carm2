class SchoolTestResult
  include Mongoid::Document
  field :student_id, type: String
  field :school_test_id, type: String
  field :results, type: Hash  #{:subject => :score}

  index({ student_id: 1, school_test_id: 1 }, { unique: true })
end
