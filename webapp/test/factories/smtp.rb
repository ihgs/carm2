FactoryGirl.define do
  factory :smtp_config do
    smtp({
      address: ENV["DOCKER_HOST_IP"] || '192.168.33.50',
      port: 1025
      })
  end

end
