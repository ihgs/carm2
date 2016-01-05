module Storage
  module Localfile

    def upload file_id, content_type, content
      data_file = File.join(@base_dir, file_id)
      type_file = File.join(@base_dir, "#{file_id}.ct")

      File.write data_file, content
      File.write type_file, content_type
    end

    def download file_id
      data_file = File.join(@base_dir, file_id)
      File.read data_file
    end

    def delete file_id
      #TODO
    end
  end
end
