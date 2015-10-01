FactoryGirl.define do
  factory :user do
    email "admin@example.com"
    password "userpassword"
    password_confirmation "userpassword"
  end
end
