FactoryGirl.define do
  factory :smtp_config do
    smtp({
      address: ENV["DOCKER_HOST_IP"],
      port: 1025
      })
  end

end
