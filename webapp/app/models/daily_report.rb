class DailyReport
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date
  field :grade, type: String
  field :subject, type: String
  field :students, type: Array  #[{"出欠":false, "test_result":}]
  field :contents, type: Array
  field :homeworks, type: Array
  field :blackboard_pics, type: Array #{{"id":attached_file_id}}
  field :note, type: String
  attr_accessor :blackboard_pic_data_list
  before_save :upload_files
  #TODO delete attached_file
  # before_delete

  validate :check_image

  def upload_files
    if self.blackboard_pic_data_list
      self.blackboard_pics =[]
      self.blackboard_pic_data_list.values.each do |bbpd|
        af = AttachedFile.build(bbpd["blackboard_pic_data"])
        af.category = "daily_report_blackboard"
        af.save
        self.blackboard_pics.push(af.id)
      end
    end

    if self.students
      self.students.each do |student|
        if student.has_key?(:test_file_data)
          af = AttachedFile.build(student[:test_file_data])
          af.category = "daily_report_test_file"
          af.save

          student.delete(:test_file_data)
          student[:test_file] = af.id
        end
      end
    end
  end

  def check_image
    if self.blackboard_pic_data_list
      self.blackboard_pic_data_list.values.each do |bbpd|
        data = bbpd["blackboard_pic_data"]
        unless data
          if data.size > 5.megabytes
            errors.add(:blackboard_pic_data_list,"5MB以下にしてください")
          end
        end
      end
    end
  end
end
