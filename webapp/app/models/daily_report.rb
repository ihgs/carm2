class DailyReport
  include Mongoid::Document
  include Mongoid::Timestamps
  field :date, type: Date
  field :grade, type: String
  field :subject, type: String
  field :students, type: Array  #[{"出欠":false, "test_result":}]
  field :contents, type: Array
  field :homeworks, type: Array
  # field :test_result_pics, type: Array
  # field :blackboard_pics, type: Array #{{"id":attached_file_id}}
  field :note, type: String
  # attr_accessor :blackboard_pic_data_list, :test_result_pic_data_list
  #before_save :upload_files
  #TODO delete attached_file
  # before_delete

  #validate :check_image

  # def upload_files
  #   if self.blackboard_pic_data_list
  #     self.blackboard_pics = [] unless self.blackboard_pics
  #     get_array(self.blackboard_pic_data_list).each do |bbpd|
  #       af = AttachedFile.build(bbpd["blackboard_pic_data"])
  #       af.category = "daily_report_blackboard"
  #       af.save
  #       self.blackboard_pics.push(af.id.to_s)
  #     end
  #   end
  #
  #   if self.test_result_pic_data_list
  #     self.test_result_pics = [] unless self.test_result_pics
  #     get_array(self.test_result_pic_data_list).each do |trpd|
  #       af = AttachedFile.build(trpd["test_result_pic_data"])
  #       af.category = "daily_report_test_file"
  #       af.save
  #       self.test_result_pics.push(af.id.to_s)
  #     end
  #   end
  #
  # end

  # def check_image
  #   if self.blackboard_pic_data_list
  #     get_array(self.blackboard_pic_data_list).each do |bbpd|
  #       data = bbpd["blackboard_pic_data"]
  #       if data
  #         if data.size > 5.megabytes
  #           errors.add(:blackboard_pic_data_list,"5MB以下にしてください")
  #         end
  #       end
  #     end
  #   end
  # end

  private
    def get_array target
      if target.is_a? Hash
        target.values
      elsif target.is_a? Array
        target
      else
        raise Exception
      end
    end
end
