FactoryGirl.define do

  factory :school, :class => 'School' do
    name "第一"
    kind "小学校"
    note "第1番目の小学校"
    address ({
      post: "111-0000",
      prefecture: "大阪",
      city: "大阪市",
      address1: "北区中之島１丁目",
      address2: "マンションA"
    })
  end

end
