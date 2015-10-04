require 'openstack'
module Storage
  class Swift

    @auth_method = "password"

    def initialize opts
      @opts = opts
    end

    def container container_name
      os = OpenStack::Connection.create(@opts)

      os.create_container(container_name)  unless os.container_exists?(container_name)

      os.container(container_name)
    end


  end
end

opts = {
  :username => "test:tester",
  :api_key=> "testing",
  :auth_method=> "password",
  :auth_url => "http://192.168.33.50:12345/auth/v1.0",
  :service_type=>"object-store"}

swift = Storage::Swift.new(opts)
con = swift.container("swift")

require 'pry'
binding.pry
