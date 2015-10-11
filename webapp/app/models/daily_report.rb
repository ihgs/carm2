class DailyReport
  include Mongoid::Document
  field :date, type: Date
  field :grade, type: String
  field :subject, type: String
  field :students, type: Array  #[{"出欠":false, "test_result":}]
  field :content, type: Hash
  field :homework, type: Array
  field :tests, type: Array
  field :note, type: String
end
