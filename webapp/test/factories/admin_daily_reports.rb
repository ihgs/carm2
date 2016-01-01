FactoryGirl.define do
  factory :admin_daily_report, :class => 'Admin::DailyReport' do
    date ""
grade ""
subject ""
homework ""
tests ""
note ""
other ""
  end

end
