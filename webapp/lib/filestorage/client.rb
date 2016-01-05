require_relative 'swift/swift'
require_relative 'file/localfile'

module FileStorage

  class Client
    if "swift" == Rails.application.config.filestorage.type
      include Storage::Swift
      def initialize
        @opts = Rails.application.config.filestorage.opts
        @container_name = Rails.application.config.filestorage.opts[:container_name]
      end
    elsif "file" == Rails.application.config.filestorage.type
      include Storage::Localfile

      def initialize
        @base_dir = Rails.application.config.filestorage.opts[:base_directory]
      end
    end
  end
end
