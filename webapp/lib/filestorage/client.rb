require_relative 'swift/swift'

module FileStorage

  class Client
    if "swift" == Rails.application.config.filestorage.type
      include Storage::Swift
      def initialize
        @opts = Rails.application.config.filestorage.opts
        @container_name = Rails.application.config.filestorage.opts[:container_name]
      end
    end
  end
end
