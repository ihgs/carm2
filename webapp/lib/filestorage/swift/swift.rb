require 'openstack'

#FIXME https://github.com/ruby-openstack/ruby-openstack/issues/44
module OpenStack
  module Swift
    class ChunkedConnectionWrapper
      def read(length, out_str)
        s = @file.read(length)

        if s.nil?
          return nil
        end

        out_str << s

        s
      end
    end
  end
end
module Storage
  module Swift

    @auth_method = "password"


    def container
      os = OpenStack::Connection.create(@opts)

      os.create_container(@container_name) unless os.container_exists?(@container_name)
      os.container(@container_name)
    end


    def upload file_id, content_type, content
      con = container
      con.create_object(file_id, {content_type: content_type}, content)
    end

    def download file_id
      file_object = container.get_object file_id
      file_object.data
    end

    def delete file_id
      container.delete_object file_id
    end
  end
end
